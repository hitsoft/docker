FROM hitsoft/base
MAINTAINER Konstantin Borisov <konstantin.borisov@gmail.com>

RUN apt-get update \
	&& apt-get install --assume-yes --no-install-recommends -yqq \
	    busybox \
        postfix \
        postfix-pcre \
        postfix-policyd-spf-perl \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/var/lib/postfix/", "/var/spool/postfix/"]

EXPOSE 25 587

ENTRYPOINT ["/entrypoint.sh"]

CMD []