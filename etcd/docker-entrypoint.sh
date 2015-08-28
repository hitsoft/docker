#!/usr/bin/env bash
set -e

if [ "$1" = 'etcd' ]; then
	cd /opt/etcd-browser
	exec nodejs server.js &

	mkdir -p /data/db
fi

exec "$@"
