#!/bin/bash

# Reconfigures the Replica Set configuration
# to elevate DC2 as primary when DC1 has gone down,
# by assigning p0/v0 to the DC1 nodes

# This script is for a 5-node deployment
# (2 in DC1 + 3 in DC2) 

source demo.conf

port=$(($BASE_MDB_PORT + 2))

echo "Reconfiguring RS..."
mongosh --quiet --port $port --eval "

  cfg = rs.conf();
  cfg.members[0].priority = 0;
  cfg.members[0].votes = 0;
  cfg.members[1].priority = 0;
  cfg.members[1].votes = 0;
  cfg.members[3].priority = 1;
  cfg.members[3].votes = 1;
  cfg.members[4].priority = 1;
  cfg.members[4].votes = 1;
  rs.reconfig( cfg, { force: true } );

"

