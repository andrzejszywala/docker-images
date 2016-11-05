FROM jboss/wildfly
MAINTAINER Andrzej Szywala <andrzej.szywala@gmail.com>
ADD customization $JBOSS_HOME
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/wildfly/wildfly_conf.txt
# FIX for Error: WFLYCTL0056: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current...
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current/*
ADD hellojee.war $JBOSS_HOME/standalone/deployments/hellojee.war