#!/bin/bash

# Deploys a sample 2-DC architecture:
#   DC 1: 2 voting RS members
#   DC 2: 1 voting + 2 non-voting RS members

# Deploys a 5-node RS on the local machine.
./1-launchRS.sh 5

echo "Waiting a bit before configuring non-voting members..."
sleep 10

# Reconfigures node 3 to priority:0, votes: 0
# (Node numbering starts at 0)
./setp0v0.sh 3

# Reconfigures node 4 to priority:0, votes: 0
# (Node numbering starts at 0)
./setp0v0.sh 4

