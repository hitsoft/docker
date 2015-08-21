#!/usr/bin/env bash
set -e

chown -R mongodb /data/db
chown -R mongodb /data/log

if [ "${1:0:1}" = '-' ]; then
	set -- mongod "$@"
fi

if [ "$1" = 'mongod' ]; then

	numa='numactl --interleave=all'
	if ${numa} true &> /dev/null; then
		set -- $numa "$@"
	fi

	exec gosu mongodb "$@"
fi

exec "$@"