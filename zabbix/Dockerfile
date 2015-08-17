FROM hitsoft/base

MAINTAINER Konstantin Borisov <smeagol74@gmail.com>

RUN apt-get update && \
     apt-get install -y wget apt-utils && \
     wget http://repo.zabbix.com/zabbix/2.4/debian/pool/main/z/zabbix-release/zabbix-release_2.4-1+jessie_all.deb && \
     dpkg -i zabbix-release_2.4-1+jessie_all.deb && \
     apt-get update && \
     apt-get install -y zabbix-frontend-php zabbix-java-gateway zabbix-server-pgsql

