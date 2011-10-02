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
  pointImage.src = "images/point.png"

  speed = 5
  p1 = {x:20,y:20}
  angle = 35
  radians = 0
  xunits = 0
  yunits = 0
  ball = {x:p1.x, y:p1.y}
  points = new Array()

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)

    ball.x += xunits
    ball.y += yunits

    points.push({x:ball.x,y:ball.y})

    for p in points
      context.drawImage(pointImage, p.x, p.y,1,1)

    context.fillStyle = '#000000'
    context.beginPath()
    context.arc(ball.x,ball.y,15,0,Math.PI*2,true)
    context.closePath()
    context.fill()

    if ball.x > theCanvas.width || ball.x < 0
      angle = 180 - angle
      updateBall()
    else if ball.y > theCanvas.height || ball.y < 0
      angle = 360 - angle
      updateBall()

  updateBall = ->
    radians = angle * Math.PI / 180
    xunits = Math.cos(radians) * speed
    yunits = Math.sin(radians) * speed

  updateBall()
  setInterval(drawScreen,33)

d = new Debugger
canvasApp()