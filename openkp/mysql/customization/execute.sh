#!/bin/bash
JBOSS_HOME=/opt/wildfly/openkp
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    sleep 1
  done
}

echo "=> Starting WildFly server"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -c $JBOSS_CONFIG & 

echo "=> Waiting for the server to boot"
wait_for_server

echo "=> Executing the commands"
echo "=> MYSQL_HOST: " $MYSQL_HOST
echo "=> MYSQL_PORT: " $MYSQL_PORT
echo "=> MYSQL (docker host): " $DB_PORT_3306_TCP_ADDR
echo "=> MYSQL (docker port): " $DB_PORT_3306_TCP_PORT
echo "=> MYSQL (kubernetes host): " $MYSQL_SERVICE_HOST
echo "=> MYSQL (kubernetes port): " $MYSQL_SERVICE_PORT
$JBOSS_CLI -c << EOF
batch
# dodanie modulu dla sterownika mysql
module add --name=com.mysql --resources=/opt/wildfly/customization/mysql-connector-java-5.1.34.jar --dependencies=javax.api,javax.transaction.api
# dodanie sterownika mysql
/subsystem=datasources/jdbc-driver=mysql:add(driver-name=mysql,driver-module-name=com.mysql,driver-xa-datasource-class-name=com.mysql.jdbc.jdbc2.optional.MysqlXADataSource)
# dodanie datasourca
data-source add --name=mysqlDS --driver-name=mysql --jndi-name=java:jboss/datasources/OpenKPMySQLDS --connection-url=jdbc:mysql://$DB_PORT_3306_TCP_ADDR:$DB_PORT_3306_TCP_PORT/sample?useUnicode=true&amp;characterEncoding=UTF-8 --user-name=mysql --password=mysql --use-ccm=false --max-pool-size=25 --blocking-timeout-wait-millis=5000 --enabled=true
# ustawienie datasourca mysql jako domyslnego
/subsystem=ee/service=default-bindings:write-attribute(name="datasource", value="java:jboss/datasources/OpenKPMySQLDS")
# Execute the batch
run-batch
EOF

echo "=> Shutting down WildFly"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi
#deploy
cp /opt/wildfly/customization/openkp.war $JBOSS_HOME/$JBOSS_MODE/deployments/openkp.war

echo "=> Restarting WildFly"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -c $JBOSS_CONFIG
