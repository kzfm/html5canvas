class Debugger
  log: (message) ->
    try
      console.log(message)
    catch exception
      return

canvasSupport = -> Modernizr.canvas

canvasApp = ->
  return if !canvasSupport()

  theCanvas = document.getElementById("canvas")
  context = theCanvas.getContext("2d")

  pointImage = new Image()
  pointImage.src = "/images/point.png"

  p0 = {x:150, y:440}
  p1 = {x:450, y:10}
  p2 = {x:50, y:10}
  p3 = {x:325, y:450}
  ball = {x:0, y:0, speed:0.01, t:0}
  points = new Array()

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)

    t = ball.t
    cx = 3 * (p1.x - p0.x)
    bx = 3 * (p2.x - p1.x) - cx
    ax = p3.x - p0.x - cx - bx

    cy = 3 * (p1.y - p0.y)
    bY = 3 * (p2.y - p1.y) - cy
    ay = p3.y - p0.y - cy - bY

    xt = ax*(t*t*t) + bx*(t*t) + cx*t + p0.x
    yt = ay*(t*t*t) + bY*(t*t) + cy*t + p0.y

    ball.t += ball.speed

    ball.t = 1 if ball.t > 1

    context.font = "1-px sans"
    context.fillStyle = "#ff0000"
    context.beginPath()
    context.arc(p0.x, p0.y, 8, 0, Math.PI*2, true)
    context.closePath()
    context.fill()
    context.fillStyle = "#ffffff"
    context.fillText("0",p0.x-2,p0.y+2)

    context.font = "1-px sans"
    context.fillStyle = "#ff0000"
    context.beginPath()
    context.arc(p1.x, p1.y, 8, 0, Math.PI*2, true)
    context.closePath()
    context.fill()
    context.fillStyle = "#ffffff"
    context.fillText("1",p1.x-2,p1.y+2)

    context.font = "1-px sans"
    context.fillStyle = "#ff0000"
    context.beginPath()
    context.arc(p2.x, p2.y, 8, 0, Math.PI*2, true)
    context.closePath()
    context.fill()
    context.fillStyle = "#ffffff"
    context.fillText("2",p2.x-2,p2.y+2)

    context.font = "1-px sans"
    context.fillStyle = "#ff0000"
    context.beginPath()
    context.arc(p3.x, p3.y, 8, 0, Math.PI*2, true)
    context.closePath()
    context.fill()
    context.fillStyle = "#ffffff"
    context.fillText("3",p3.x-2,p3.y+2)

    points.push({x:xt, y:yt})
    for p in points
      context.drawImage(pointImage,p.x,p.y,1,1)

    context.fillStyle = "#000000"
    context.beginPath()
    context.arc(xt, yt, 5, 0, Math.PI*2, true)
    context.closePath()
    context.fill()

  setInterval(drawScreen, 33)

d = new Debugger
canvasApp()