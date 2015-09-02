#!/usr/bin/env bash

function build() {
    NAME=$1
    pushd ${NAME}
        echo "" >&2
        echo "" >&2
        echo "###" >&2
        echo "### Building hitsoft/${NAME}" >&2
        echo "###" >&2
        echo "" >&2
        echo "" >&2
        docker build -t hitsoft/${NAME} .
    popd
}

SCRIPT=$(readlink -f $0)
DIR=$(dirname $SCRIPT)

pushd ${DIR}
# Base and intermediate
    build base
    build java
    build php
# Final services
    build mariadb
    build mongo
    build nginx
    build postgres
    build samba
    build wordpress
    build zookeeper
    build tomcat
    build etcd
    build postfix

echo "" >&2
echo "" >&2
echo "###" >&2
echo "### Well done!" >&2
echo "###" >&2
popd