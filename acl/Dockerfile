FROM jboss/wildfly
MAINTAINER Andrzej Szywala 
ADD acl.cli $JBOSS_HOME/acl.cli
ADD execute.sh $JBOSS_HOME/execute.sh

RUN cp $JBOSS_HOME/standalone/configuration/standalone.xml $JBOSS_HOME/standalone/configuration/standalone-acl.xml
RUN cp $JBOSS_HOME/standalone/configuration/standalone-ha.xml $JBOSS_HOME/standalone/configuration/standalone-ha-acl.xml
RUN cp $JBOSS_HOME/standalone/configuration/standalone-full.xml $JBOSS_HOME/standalone/configuration/standalone-full-acl.xml
RUN cp $JBOSS_HOME/standalone/configuration/standalone-full-ha.xml $JBOSS_HOME/standalone/configuration/standalone-full-ha-acl.xml

ENV CONFIG_XML standalone-full-ha-acl.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/acl.cli
ENV CONFIG_XML standalone-full-acl.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/acl.cli
ENV CONFIG_XML standalone-acl.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/acl.cli
ENV CONFIG_XML standalone-ha-acl.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/acl.cli
# WFLYCTL0056: Could not rename /opt/coig/wildfly/standalone/configuration/standalone_xml_history/current to /opt/coig/wildfly/standalone/configuration/standalone_xml_history/20180415-085446266: java.nio.file.DirectoryNotEmptyException: /opt/coig/wildfly/standalone/configuration/standalone_xml_history/current
RUN rm -R $JBOSS_HOME/standalone/configuration/standalone_xml_history
ENTRYPOINT $JBOSS_HOME/execute.sh