#!/bin/sh

DB_HOST=${DB_HOST:-}
DB_PORT=${DB_PORT:-}
DB_NAME=${DB_NAME:-}
DB_USER=${DB_USER:-}
DB_PASS=${DB_PASS:-}
DB_TYPE=${DB_TYPE:-}

if [ -n "${MYSQL_PORT_3306_TCP_ADDR}" ]; then
  DB_TYPE=mysql
  DB_HOST=${DB_HOST:-${MYSQL_PORT_3306_TCP_ADDR}}
  DB_PORT=${DB_PORT:-${MYSQL_PORT_3306_TCP_PORT}}

  DB_USER=${DB_USER:-${MYSQL_ENV_MYSQL_USER}}
  DB_PASS=${DB_PASS:-${MYSQL_ENV_MYSQL_PASSWORD}}
  DB_NAME=${DB_NAME:-${MYSQL_ENV_MYSQL_DATABASE}}
fi

/sbin/setuser zabbix sed 's/{{DB_HOST}}/'"${DB_HOST}"'/' -i /etc/zabbix/zabbix_server.conf
/sbin/setuser zabbix sed 's/{{DB_NAME}}/'"${DB_NAME}"'/' -i /etc/zabbix/zabbix_server.conf
/sbin/setuser zabbix sed 's/{{DB_USER}}/'"${DB_USER}"'/' -i /etc/zabbix/zabbix_server.conf
/sbin/setuser zabbix sed 's/{{DB_PASS}}/'"${DB_PASS}"'/' -i /etc/zabbix/zabbix_server.conf

MYSQL=/usr/bin/mysql\ "-h${DB_HOST}"\ "-u${DB_USER}"\ "-p${DB_PASS}"\ "${DB_NAME}"

echo "mysql: ${MYSQL}"

count_tables=$(echo "SHOW TABLES; SELECT FOUND_ROWS();" | ${MYSQL} | grep "[0-9]")

echo "tables count: ${count_tables}"

if [ ${count_tables} -eq 0 ]; then
  ${MYSQL} < /usr/share/zabbix-server-mysql/schema.sql
  ${MYSQL} < /usr/share/zabbix-server-mysql/images.sql
  ${MYSQL} < /usr/share/zabbix-server-mysql/data.sql
fi

exec /sbin/setuser zabbix /usr/sbin/zabbix_server 2>&1