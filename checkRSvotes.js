// Lists RS members: id, vote count, and Primary/Secondary

conf=rs.conf()
state=rs.status()
rsNodeCount=state.members.length

for (let i=0; i<rsNodeCount; i++) { print( state.members[i]._id, conf.members[i].votes+'vote', state.members[i].stateStr) }

