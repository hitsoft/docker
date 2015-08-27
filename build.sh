#!/usr/bin/env bash

function build() {
    NAME=$1
    pushd ${NAME}
        echo "\n\n\nBuilding ${NAME}\n\n\n"
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
popd