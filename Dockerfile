FROM centos:7
MAINTAINER Satish Aherkar <aherkarsatish1@gmail.com>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40


RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y install epel-release && \
    yum -y install wget && \
    yum-config-manager --disable remi-php54 && \
    yum-config-manager --enable remi-php73 && \
    yum -y install httpd && \
    yum -y install mariadb-server mariadb-client && \
    yum -y install php php-mysql php-pdo php-gd php-mbstring php-xml php-intl texlive && \
    yum clean all

ADD src/mediawiki-1.32.0/ /var/www/html/

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
