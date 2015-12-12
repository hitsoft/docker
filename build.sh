#!/usr/bin/env bash

function imageByTag() {
    IMAGE=$1
    TAG=$2
    docker images --no-trunc ${IMAGE} | egrep "^${IMAGE}\s+${TAG}+\s+" | awk '{print $3}'
}

function versions() {
    IMAGE=$1
    docker images --no-trunc ${IMAGE} | egrep "^${IMAGE}\s+[0-9]+\s+" | awk '{print $3" "$2}' | sort --reverse
}

function maxVersion() {
    IMAGE=$1
    RES=$(versions ${IMAGE} | head -n 1 | awk '{print $2}')
    if [[ -z ${RES} ]]; then
      echo 0
    else
      echo ${RES}
    fi
}

function build() {
    NAME=$1
    IMAGE=hitsoft/${NAME}
    pushd ${NAME}
        echo "" >&2
        echo "" >&2
        echo "###" >&2
        echo "### Building ${IMAGE}" >&2
        echo "###" >&2
        echo "" >&2
        echo "" >&2
        LAST_ID=$(imageByTag ${IMAGE} latest)
        docker build -t ${IMAGE} .
        NEW_ID=$(imageByTag ${IMAGE} latest)
        if [[ "_${NEW_ID}_" == "_${LAST_ID}_" ]]; then
            echo "!!! Nothing changed since last build" >&2
        else
            TAG=$(( $(maxVersion ${IMAGE}) + 1 ))
            docker tag ${NEW_ID} ${IMAGE}:${TAG}
            echo "!!! New image ${IMAGE}:${TAG} built" >&2
        fi
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
    build activemq
    build etcd
    build mariadb
    build mongo
    build nginx
#    build postfix
#    build samba
    build tomcat
#    build wordpress
    build zabbix-server
# Not used yet
#    build postgres
#    build zookeeper

echo "" >&2
echo "" >&2
echo "###" >&2
echo "### Well done!" >&2
echo "###" >&2
popd
