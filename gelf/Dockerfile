FROM jboss/wildfly
MAINTAINER Andrzej Szywala 
ADD gelf-module $JBOSS_HOME/modules/system/layers/base/
ADD execute.sh $JBOSS_HOME/execute.sh
ADD gelf.cli $JBOSS_HOME/gelf.cli

ENV GRAYLOG_URL=""
ENV GRAYLOG_PORT=""
ENV APP="hellojee"
ENV APPVER="1.0"

RUN cp $JBOSS_HOME/standalone/configuration/standalone.xml $JBOSS_HOME/standalone/configuration/standalone-gelf.xml
RUN cp $JBOSS_HOME/standalone/configuration/standalone-ha.xml $JBOSS_HOME/standalone/configuration/standalone-ha-gelf.xml
RUN cp $JBOSS_HOME/standalone/configuration/standalone-full.xml $JBOSS_HOME/standalone/configuration/standalone-full-gelf.xml
RUN cp $JBOSS_HOME/standalone/configuration/standalone-full-ha.xml $JBOSS_HOME/standalone/configuration/standalone-full-ha-gelf.xml

ENV CONFIG_XML standalone-full-ha-gelf.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/gelf.cli
ENV CONFIG_XML standalone-full-gelf.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/gelf.cli
ENV CONFIG_XML standalone-gelf.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/gelf.cli
ENV CONFIG_XML standalone-ha-gelf.xml
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/gelf.cli
# WFLYCTL0056: Could not rename /opt/coig/wildfly/standalone/configuration/standalone_xml_history/current to /opt/coig/wildfly/standalone/configuration/standalone_xml_history/20180415-085446266: java.nio.file.DirectoryNotEmptyException: /opt/coig/wildfly/standalone/configuration/standalone_xml_history/current
RUN rm -R $JBOSS_HOME/standalone/configuration/standalone_xml_history
ENTRYPOINT $JBOSS_HOME/execute.sh