#!/usr/bin/env bash

function build() {
    NAME=$1
    pushd ${NAME}
        echo ""
        echo ""
        echo "###"
        echo "### Building hitsoft/${NAME}"
        echo "###"
        echo ""
        echo ""
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

echo ""
echo ""
echo "###"
echo "### Well done!"
echo "###"
popd