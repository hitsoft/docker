#!/usr/bin/env bash
set -e

if [ "$1" == "/sbin/my_init" ]; then
	echo "Starting Zabbix"
fi

exec "$@"