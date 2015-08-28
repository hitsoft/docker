#!/usr/bin/env bash

FILE=$(tempfile)

if [ "$1" == "dump" ]; then

etcd-dump --file ${FILE} dump
jsonlint --pretty-print ${FILE}

fi
if [ "$1" == "restore" ]; then
read dump
echo "$dump" > ${FILE}
etcd-dump --file ${FILE} restore
fi

rm ${FILE}