#!/bin/sh

docker run --name lb -it --rm --net mynet -p 80:8080 -p 443:8443 jboss/wildfly /opt/jboss/wildfly/bin/standalone.sh -c standalone-load-balancer.xml -b lb -bmanagement lb -bprivate lb 
