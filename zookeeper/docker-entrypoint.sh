#!/usr/bin/env bash
set -e

if [ "$1" = 'zkServer' ]; then
	if [ ! -z "${ZK_SERVER_NUMBER}" ]
	printf  > /var/lib/zookeeper/myid
	printf "Starting Zookeeper server $(cat /etc/zookeeper/myid)\n"
	/usr/share/zookeeper/bin/zkServer.sh start-foreground
fi

exec "$@"