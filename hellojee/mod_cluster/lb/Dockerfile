FROM fedora
RUN dnf -y update
RUN dnf -y install httpd
RUN dnf -y install mod_cluster
RUN dnf -y install mod_ssl
#RUN dnf -y install openssl
RUN dnf clean all

RUN sed -i "s|LoadModule proxy_balancer_module|#LoadModule proxy_balancer_module|" /etc/httpd/conf.modules.d/00-proxy.conf

ADD mod_cluster.conf /etc/httpd/conf.d/mod_cluster.conf
RUN mkdir /etc/httpd/conf/certs
RUN openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=PL/ST=Slaskie/L=Katowice/O=aszywala/OU=aszywala/CN=Andrzej Szywala" \
    -keyout www.aszywala.key \
    -out www.aszywala.crt
EXPOSE 80
EXPOSE 443
CMD ["/sbin/httpd", "-DFOREGROUND"]