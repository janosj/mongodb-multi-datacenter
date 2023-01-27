#!/bin/bash
# Runs a simple node client that inserts a document every second.

source demo.conf

USAGE="USAGE: runInserts.sh <writeConcern | majority>"

writeConcern="${1:-majority}"
MDB_URI="$MDB_URI&w=$writeConcern"

URI=$MDB_URI node client-insertRecords.js

