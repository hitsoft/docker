#!/usr/bin/env bash
set -e

if [ "$1" = 'zkServer' ]; then
#	cd /opt/zk-web
#	lein run &

	cd /opt/zkui
    java -jar zkui-2.0-SNAPSHOT-jar-with-dependencies.jar &

	if [ ! -z "${ZK_SERVER_NUMBER}" ]; then
		printf "${ZK_SERVER_NUMBER}" > /etc/zookeeper/conf/myid
	else
		printf "1" > /etc/zookeeper/conf/myid
	fi
	mkdir -p /data/db
	mkdir -p /data/log
	rm -rf /var/log/zookeeper
	ln -sf /data/log /var/log/zookeeper
	printf "Starting Zookeeper server $(cat /etc/zookeeper/conf/myid)\n"
	/usr/share/zookeeper/bin/zkServer.sh start-foreground
fi

exec "$@"