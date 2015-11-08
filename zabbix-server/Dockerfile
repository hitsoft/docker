FROM hitsoft/php
MAINTAINER Konstantin Borisov <smeagol74@gmail.com>

RUN wget http://repo.zabbix.com/zabbix/2.4/debian/pool/main/z/zabbix-release/zabbix-release_2.4-1+jessie_all.deb \
     && dpkg -i zabbix-release_2.4-1+jessie_all.deb \
     && apt-get update \
     && apt-get install --assume-yes --no-install-recommends \
          zabbix-server-mysql \
          zabbix-frontend-php \
 	 && apt-get clean \
	 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /etc/my_init.d \
     && mkdir /var/run/zabbix \
     && chown -R zabbix:zabbix /var/run/zabbix \
     && chown -R zabbix:zabbix /etc/zabbix

COPY zabbix_server.conf /etc/zabbix/zabbix_server.conf
COPY zabbix-server.init.d /etc/my_init.d/10-zabbix-server.sh
COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /var/www/html

EXPOSE 10051
EXPOSE 9000
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/my_init"]
