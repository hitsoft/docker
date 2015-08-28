#!/usr/bin/env bash
set -e

if [ "$1" = 'etcd' ]; then
    #CMD ["nodejs", "server.js"]
	cd /opt/etcd-browser
	nodejs server.js &
fi

exec "$@"