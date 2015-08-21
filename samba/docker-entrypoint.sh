#!/usr/bin/env bash
set -e

if [ "$1" = 'smbd' ]; then
	exec gosu "$@"
fi

exec "$@"