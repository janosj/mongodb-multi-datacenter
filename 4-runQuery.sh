#!/bin/bash
# Runs a simple node client that inserts a document every second.

source demo.conf

USAGE="USAGE: runQuery.sh <readPreference | primary>"

readPreference="${1:-primary}"
MDB_URI="$MDB_URI&readPreference=$readPreference"

URI=$MDB_URI node client-queryData.js

