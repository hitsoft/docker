FROM hitsoft/base
MAINTAINER Konstantin Borisov <konstantin.borisov@gmail.com>

RUN apt-get update \
	&& apt-get install --assume-yes --no-install-recommends -yqq \
	    busybox \
	    libsasl2-modules \
	    sasl2-bin \
        postfix \
        postfix-pcre \
        postfix-policyd-spf-perl \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME [ "/var/spool/postfix/", "/etc/postfix/" ]

EXPOSE 25 587

ENTRYPOINT ["/entrypoint.sh"]

CMD []