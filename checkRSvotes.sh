#!/bin/bash
# Connects to the RS with commands to (manually) execute rs.status().
# Documentation: https://www.mongodb.com/docs/manual/tutorial/deploy-replica-set/

source demo.conf

# Note the read preference!
# By default, mongosh will not connect to a secondary.
MDB_URI="$MDB_URI&readPreference=primaryPreferred"

echo "Connecting to Mongo at $MDB_URI..."
mongosh --quiet "$MDB_URI" --shell --eval "
  load('checkRSvotes.js')
  quit()
"


