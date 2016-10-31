FROM centos
MAINTAINER OpenKP <openkp@op.pl>

# Aktualizacja systemu
RUN yum -y update && yum clean all

# Instalacja potrzebnych pakietow
RUN yum -y install unzip wget && yum clean all

# Utworzenie uzytkownika wildfly
RUN groupadd -r wildfly -g 1000 && useradd -u 1000 -r -g wildfly -m -d /opt/wildfly -s /sbin/nologin -c "wildfly user" wildfly

# Katalog roboczy
WORKDIR /opt/wildfly

# Przejscie na roota
USER root

# Instalacja javy
RUN  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm

RUN yum -y install /tmp/jdk-8-linux-x64.rpm && yum clean all

RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
RUN rm /tmp/jdk-8-linux-x64.rpm
# Przejscie na uzytkownika wildfly
USER wildfly

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/java/latest

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 8.2.0.Final

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd /opt/wildfly  
RUN curl -O http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.zip 
RUN unzip wildfly-$WILDFLY_VERSION.zip 
RUN mv /opt/wildfly/wildfly-$WILDFLY_VERSION /opt/wildfly/openkp 
RUN rm wildfly-$WILDFLY_VERSION.zip

# Wystawienie portów
EXPOSE 8080 9990

ADD customization /opt/wildfly/customization/
# Uruchomienie Wildfly
CMD ["/opt/wildfly/customization/execute.sh"]
