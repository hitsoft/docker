#!/usr/bin/env bash

ACTIVEMQ_EXECUTABLE=${ACTIVEMQ_HOME}/bin/activemq
ACTIVEMQ_ARGS=console

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child" 2>/dev/null
}
trap _term SIGTERM

$ACTIVEMQ_EXECUTABLE $ACTIVEMQ_ARGS &
PID=$!

wait $PID