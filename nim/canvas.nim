import jscanvas,strformat

var ctx: CanvasContext

proc use* (c: CanvasContext)=
  ctx = c

proc fill* (r,g,b,a: int)=
  ctx.fillStyle=(&"rgba({r},{g},{b},{a}")

proc fill* (r,g,b:int)=
  fill(r,g,b,255)

proc fill* (c: int,a: int)=
  fill(c,c,c,a)

proc fill* (c: int)=
  fill(c,255)

proc rect* (x,y,w,h:int)=
  ctx.fillRect(x,y,w,h)

proc rect* (x,y,w,h,p:int)=
  let ep = 2 * p
  rect(x + p,y + p,w - p,h - p)

proc clear* ()=
  rect(0,0,ctx.canvas.width,ctx.canvas.height)

proc clear* (r,g,b,a: int)=
  fill(r,g,b,a)
  clear()

proc clear* (r,g,b: int)=
  clear(r,g,b,255)

proc clear* (c,a: int)=
  clear(c,c,c,a)

proc clear* (c: int)=
  clear(c,255)
