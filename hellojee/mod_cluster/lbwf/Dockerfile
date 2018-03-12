FROM jboss/wildfly
ADD customization $JBOSS_HOME
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/wildfly/wildfly_conf.txt
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-load-balancer.xml", "-b", "lb", "-bprivate", "lb"]

