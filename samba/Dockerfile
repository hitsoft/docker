# vim:set ft=dockerfile:
FROM hitsoft/base

MAINTAINER Konstantin Borisov <smeagol74@gmail.com>

VOLUME /data
EXPOSE 137/udp 138/udp 139/tcp 445/tcp

ENV DEBIAN_FRONTEND noninteractive

RUN \
	apt-get update && \
	apt-get install --no-install-recommends -y samba && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Pregenerate password database to prevent warning messages on container startup
RUN /usr/sbin/smbd && sleep 10 && smbcontrol smbd shutdown

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /etc/samba
VOLUME /data

ENTRYPOINT ["/entrypoint.sh"]

CMD ["smbd", "-FSD", "-d1"]