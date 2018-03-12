FROM jboss/wildfly
MAINTAINER Andrzej Szywala <andrzej.szywala@gmail.com>
ADD hellojee.war $JBOSS_HOME/standalone/deployments/hellojee.war
# CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-Djboss.modcluster.proxylist=lb"]
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-ha.xml", "-b", "0.0.0.0"]
