import map
import binaryheap, tables

# priority = cost + hueristic
type
  Felem = tuple[node: vec2,priority,cost: int]
  CameFrom = tuple[node: vec2,cost: int]

iterator pathfind* (start,goal: vec2): vec2=
  var frontier = newHeap[Felem] do (a, b: Felem) -> int:
            return cmp(a.priority, b.priority)
  var cameFrom = initTable[vec2,CameFrom]()
  frontier.push((start,0,0))
  while frontier.size > 0:
    let current = frontier.pop()
    if current.node == goal:
      var c = goal
      while c != start:
        yield c
        c = cameFrom[c].node
      yield c
      break
    for next in neighbours(current.node):
      let cost = current.cost + cost(current.node,next)
      if not cameFrom.hasKey(next) or cost < cameFrom[next].cost:
        cameFrom[next] = (current.node,cost)
        let priority = cost + hueristic(next,goal)
        frontier.push((next,priority,cost))
