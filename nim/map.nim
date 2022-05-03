import random,canvas,jscanvas
import points,tables

type State* = enum
  Path,Wall,Hole

const
  mw = 9 * 4
  mh = 16 * 4

var map = newSeq[State](mw*mh)

proc inbounds* (x,y: int): bool=
  return x >= 0 and x < mw and y >= 0 and y < mh

proc get* (x,y: Natural): State= 
  return map[x + mw*y]

proc set(x,y: Natural,data: State) =
  map[x + mw*y] = data

template loopx* (body)=
  for x{.inject.} in 0..<mw:
    body

template loopy* (body)=
  for y{.inject.} in 0..<mh:
    body

template loopxy* (body)=
  loopx:
    loopy:
      body

template loopyx* (body)=
  loopy:
    loopx:
      body


proc genMap*()=
  loopxy:
    var c = rand(0..(4+16))
    var r = Path
    if c < 4:
      r = Wall
    elif c == 8:
      r = Hole
    set(x,y,r)

proc renderMap* (ctx: CanvasContext): float=
  const colors = ["#009A17","#000","#9b7653"]
  var sw = min(ctx.canvas.width/mw,ctx.canvas.height/mh)
  var s = int(sw) + 1
  # var p = max(2,s div 10)
  loopxy:
    var cx = int(sw * float(x))
    var cy = int(sw * float(y))
    ctx.fillStyle=cstring(colors[int(get(x,y))])
    rect(cx,cy,s,s)#,p)
  return sw

type vec2* = tuple[x: int,y: int]

func hueristic(a: vec2): int=
  a.x * a.x + a.y * a.y

import math

func fsqrt(x: int): int=
  int(sqrt(float(x)) * 10)

func hueristic* (a,b: vec2):int=
  fsqrt(hueristic((a.x - b.x,a.y - b.y)))

func `+`* (a,b: vec2): vec2=
  return (a.x + b.x,a.y+b.y)

proc inbounds(x: vec2): bool=
  return inbounds(x.x,x.y)

proc isInState(v: vec2,state: openArray[State]): bool=
  inbounds(v) and state.contains(get(v.x,v.y))

proc cost* (a,b: vec2): int=
  return hueristic(a,b)

let notWall = [Path,Hole]

iterator neighbours* (node: vec2): vec2=
  for i in surroundingPoints:
    if not isInState(node + i,[Path]):
      continue
    var badBoy = false
    for b in pointTable[i]:
      if not isInState(node + b,notWall):
        badBoy = true
        break
    if badBoy:
      continue
    yield node + i
