#!/bin/bash

# Restores the original vote/priority configuration.
# This script is for a 3-node deployment
# (2 in DC1 + 1 in DC2) 

source demo.conf

# Port on the active Primary
port=$(($BASE_MDB_PORT + 2))

# This has to be done in 2 steps, because 
# Non-force replica set reconfig can only add or remove at most 1 voting member.

mongosh --quiet --port $port --eval "

  state = rs.status();
  print( 'Current Vote Count: ' + state.votingMembersCount )

  print( 'Restoring votes & priority to Node 0 ...' )

  cfg = rs.conf();
  cfg.members[0].priority = 1;
  cfg.members[0].votes = 1;
  rs.reconfig( cfg );

  state = rs.status();
  print( 'New Vote Count: ' + state.votingMembersCount )

  print( '\nRestoring votes & priority to Node 1 ...' )

  cfg = rs.conf();
  cfg.members[1].priority = 1;
  cfg.members[1].votes = 1;
  rs.reconfig( cfg );

  state = rs.status();
  print( 'Final Vote Count: ' + state.votingMembersCount )

"

echo

