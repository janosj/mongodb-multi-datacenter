#!/bin/bash
# Connects to the RS with commands to (manually) execute rs.status().
# Documentation: https://www.mongodb.com/docs/manual/tutorial/deploy-replica-set/

source demo.conf

# Note the read preference!
# By default, mongosh will not connect to a secondary.
MDB_URI="$MDB_URI&readPreference=primaryPreferred"

echo "Connecting to Mongo at $MDB_URI..."
mongosh --quiet "$MDB_URI" --shell --eval "

  state=rs.status()
  rsNodeCount=state.members.length

  print('\nConnected to local ' + rsNodeCount + '-node Replica Set!')
  print('\nTo view the complete RS configuration, run the following command:')
  print('rs.conf()')
  print('\nTo show the status of all RS members, run this:')
  print('state=rs.status()')
  print('for (let i=0; i<' + rsNodeCount + '; i++) { print( state.members[i]._id, state.members[i].stateStr) }\n')
"


