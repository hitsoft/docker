#!/usr/bin/env bash
set -e

if [[ "$1" == "/sbin/my_init" ]]; then
	echo "Starting Zabbix server"
elif [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
    echo "Starting Zabbix frontend"
	if ! [ -e index.php ]; then
		echo >&2 "Zabbix frontend not found in $(pwd) - copying now..."
		if [ "$(ls -A)" ]; then
			echo >&2 "WARNING: $(pwd) is not empty - press Ctrl+C now if this is an error!"
			( set -x; ls -A; sleep 10 )
		fi
		tar cf - --one-file-system -C /usr/share/zabbix . | tar xf -
		echo >&2 "Complete! Zabbix frontend has been successfully copied to $(pwd)"
	fi
fi

exec "$@"
