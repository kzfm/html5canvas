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
  radiusInc = 1
  circle = {centerX:250, centerY:250, radius:2, angle:0}
  ball = {x:0, y:0, speed:0.1}
  points = new Array()

  pointImage = new Image()
  pointImage.src = "/images/point.png"

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)

    ball.x = circle.centerX + Math.cos(circle.angle) * circle.radius
    ball.y = circle.centerY + Math.sin(circle.angle) * circle.radius

    circle.angle += ball.speed
    circle.radius += radiusInc

    points.push({x:ball.x, y:ball.y})
    for p in points
      context.drawImage(pointImage, p.x, p.y, 1,1)

    context.fillStyle = "#00ff00"
    context.beginPath()
    context.arc(ball.x, ball.y, 15, 0, Math.PI*2, true)
    context.closePath()
    context.fill()

  setInterval(drawScreen, 33)

d = new Debugger
canvasApp()