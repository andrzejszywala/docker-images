#!/bin/bash
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_CONFIG=${JBOSS_CONFIG:-"standalone.xml"}

exec $JBOSS_HOME/bin/standalone.sh -b `hostname -i` -c $JBOSS_CONFIG 
exit $?