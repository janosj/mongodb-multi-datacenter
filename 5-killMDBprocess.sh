#!/bin/bash
# Kills the specified MDB RS member.

source demo.conf

USAGE="USAGE: kill-MDB-process.sh <node-number, where node-number starts at 0.>"

if [ -z "$1" ]; then
  echo $USAGE
  exit 1  
else
  if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "$USAGE"
    exit 1
  fi
  port=$(($BASE_MDB_PORT + $1))
  echo "Killing RS member $1 running on $port..."
fi

kill -9 $(ps aux | grep "[p]ort $port" | awk '{print $2}')

