#!/usr/bin/env bash
set -e

if [ "$1" = 'etcd' ]; then
    #CMD ["nodejs", "server.js"]
	cd /opt/etcd-browser
	exec nodejs server.js &

	mkdir -p /data/db
	exec "$@" &

	mkdir -p /data/etcd
	exec etcdfs /data/etcd http://localhost:4001 &

else
	exec "$@"
fi