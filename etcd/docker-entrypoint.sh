#!/usr/bin/env bash
set -e

if [ "$1" = 'etcd' ]; then
	mkdir -p /data/db
	exec "$@" &

	cd /opt/etcd-browser
	exec nodejs server.js &

	mkdir -p /data/etcd
	exec etcdfs /data/etcd http://localhost:4001 &

    fg %1
else
	exec "$@"
fi