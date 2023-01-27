#!/bin/bash

source demo.conf

USAGE="USAGE: restore-rs-member.sh <node-number>, where node-number starts at 0."

if [ -z "$1" ]; then
  echo "$USAGE"
  exit 1
fi

RS_NUM=$1
port=$(($BASE_MDB_PORT + $RS_NUM))
db_path=$BASE_DB_PATH/db$port/

echo
echo "Restarting RS-$RS_NUM on port $port..."

set -x
mongod --fork --port $port --dbpath $db_path --logpath $db_path/mongo$port.log --wiredTigerCacheSizeGB 0.25 --replSet "$RS_NAME"
set +x
echo

