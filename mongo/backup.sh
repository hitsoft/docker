#!/usr/bin/env bash

mkdir -p /data/backup
chown -R mongodb /data/backup
cd /data/backup
mongodump