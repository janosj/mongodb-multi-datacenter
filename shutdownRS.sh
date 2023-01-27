#!/bin/bash
# Shuts down the locally deployed replica set.

source demo.conf

db_port=$BASE_MDB_PORT
echo "Stopping $NODE_COUNT MDB processes ..."
for (( i=1; i<=$NODE_COUNT; i++ ))
do 
  echo
  echo "Stopping MDB$i on port $db_port..."
  mongosh --quiet --port $db_port --eval "db = db.getSiblingDB('admin'); db.shutdownServer();"
  ((db_port++))
done

echo 
echo "Verifying...  should see nothing running..."
echo "ps -ef | grep mongod"
ps -ef | grep mongod
echo

echo "Deleting data directories..."
rm -rf $HOME/myStuff/demos/multi-dc-demo

