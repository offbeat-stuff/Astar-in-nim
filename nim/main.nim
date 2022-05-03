import jscanvas, colors, dom, math
import canvas,map,astar

var cvs = document.getElementById("canvas").CanvasElement
cvs.width = window.innerWidth
cvs.height = window.innerHeight

var w = cvs.width
var h = cvs.height

var ctx = cvs.getContext2d()

use(ctx)

proc resize()=
  cvs.width = window.innerWidth
  cvs.height = window.innerHeight
  w = cvs.width
  h = cvs.height

# 1,3,7,1
var start: vec2 = (1,2)
var goal: vec2 = (6,1)
var progress = 0

var s : float
var points = newSeq[vec2](0)

proc genPoints()=
  points = newSeq[vec2](0)
  for i in pathfind(start,goal):
    points.add(i)

proc calPoint(a: vec2): vec2=
    let cx = (float(a.x) + 0.5) * s
    let cy = (float(a.y) + 0.5) * s
    return (int(cx),int(cy))

proc line(a,b: vec2)=
  let ap = calPoint(a)
  let bp = calPoint(b)
  # ctx.beginPath()
  ctx.moveTo(ap.x,ap.y)
  ctx.lineTo(bp.x,bp.y)
  # ctx.closePath()
  ctx.stroke()

proc mapToMap(x,y: int): vec2=
  return (int(float(x) / s),int(float(y)/s))

proc handleClick(ev: Event)=
  var mev = MouseEvent(ev)
  let p = mapToMap(mev.x,mev.y)
  if progress == 0:
    progress = 1
    start = p
  else:
    progress = 0
    goal = p
    genPoints()


document.addEventListener("click",handleClick)

var drawCalls = 0

proc draw()=
  if drawCalls == 30:
    genMap()
  resize()
  clear(0)
  s = renderMap(ctx)
  for i in 0 ..< points.high:
    line(points[i],points[i+1])
  drawCalls = (drawCalls + 1) mod 60
discard setInterval(draw,1000 div 4)
