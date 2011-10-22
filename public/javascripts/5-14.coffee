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

  speed = 4
  gravity = .1
  angle = 305
  radians = angle * Math.PI/180
  radius = 15
  vx = Math.cos(radians) * speed
  vy = Math.sin(radians) * speed

  p1 = {x:20, y:theCanvas.width-radius}
  ball = {x:p1.x, y:p1.y, velocityx: vx, velocityy:vy, radius:radius}

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)

    if ball.y + ball.radius <= theCanvas.height
      ball.velocityy += gravity
    else
      ball.velocityx = 0
      ball.velocityy = 0
      ball.y = theCanvas.height - ball.radius

    ball.y += ball.velocityy
    ball.x += ball.velocityx

    context.fillStyle = "#000000"
    context.beginPath()
    context.arc(ball.x, ball.y, ball.radius, 0, Math.PI*2, true)
    context.closePath()
    context.fill()

  setInterval(drawScreen, 33)

d = new Debugger
canvasApp()