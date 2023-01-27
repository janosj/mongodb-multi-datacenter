#!/bin/bash

# Sets an RS member to {priority:0, votes:0}
# To allow for testing of various configurations.

source demo.conf

if [ $# -lt 2 ]; then
  echo "USAGE: setp0v0.sh <rs-number, starting at 0>"
  exit 1
fi

rsID=$2

mongosh $MDB_URI --eval "

  state = rs.status();
  print( 'Current Vote Count: ' + state.votingMembersCount )

  print( 'Setting Node $rsID to priority:0, votes:0 ...' )

  cfg = rs.conf();
  cfg.members[$rsID].priority = 0;
  cfg.members[$rsID].votes = 0;
  rs.reconfig( cfg );

  state = rs.status();
  print( 'New Vote Count: ' + state.votingMembersCount )

"

echo

