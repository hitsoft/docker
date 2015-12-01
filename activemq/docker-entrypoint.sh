#!/usr/bin/env bash
set -e

if [ "_$1_" == "_/activemq.sh_" ]; then
    if [ ! -d /data/conf ]; then
        cp --recursive ${ACTIVEMQ_HOME}/conf.orig /data/conf
    fi
    ln -s /data/conf ${ACTIVEMQ_HOME}/conf

    if [ ! -d /data/data ]; then
        cp --recursive ${ACTIVEMQ_HOME}/data.orig /data/data
    fi
    ln -s /data/data ${ACTIVEMQ_HOME}/data
fi

exec "$@"