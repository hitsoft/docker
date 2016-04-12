FROM hitsoft/base

MAINTAINER Konstantin Borisov <smeagol74@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		numactl \
	&& rm -rf /var/lib/apt/lists/*

# gpg: key 7F0CEB10: public key "Richard Kreuter <richard@10gen.com>" imported
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

ENV MONGO_MAJOR 3.2
ENV MONGO_VERSION 3.2.4

RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

RUN set -x \
	&& apt-get update \
	&& apt-get install  --assume-yes --no-install-recommends \
		mongodb-org=$MONGO_VERSION \
		mongodb-org-server=$MONGO_VERSION \
		mongodb-org-shell=$MONGO_VERSION \
		mongodb-org-mongos=$MONGO_VERSION \
		mongodb-org-tools=$MONGO_VERSION \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mongodb \
	&& mv /etc/mongod.conf /etc/mongod.conf.orig

RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
RUN mkdir -p /data/log && chown -R mongodb:mongodb /data/log
RUN mkdir -p /data/backup && chown -R mongodb:mongodb /data/backup
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
COPY backup.sh /backup.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]