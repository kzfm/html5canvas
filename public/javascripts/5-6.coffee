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

  numBalls = 100
  maxSize = 8
  minSize = 5
  maxSpeed = maxSize+5
  balls = new Array()

  for i in [0..numBalls]
    tempRadius = Math.floor(Math.random()*maxSize)+minSize
    tempX = tempRadius*2 + (Math.floor(Math.random()*theCanvas.width) - tempRadius*2)
    tempY = tempRadius*2 + (Math.floor(Math.random()*theCanvas.height) - tempRadius*2)
    tempSpeed = maxSpeed - tempRadius
    tempAngle = Math.floor(Math.random()*360)
    tempRadians = tempAngle * Math.PI/ 180
    tempXunits = Math.cos(tempRadians) * tempSpeed
    tempYunits = Math.sin(tempRadians) * tempSpeed

    tempBall = {x:tempX, y:tempY, radius:tempRadius, speed:tempSpeed, angle:tempAngle, xunits:tempXunits, yunits:tempYunits}
    balls.push(tempBall)

  canvasWidthChanged = (e) ->
    target = e.target
    theCanvas.width = target.value
    drawScreen()

  canvasHeightChanged = (e) ->
    target = e.target
    theCanvas.height = target.value
    drawScreen()

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)
    context.fillStyle = '#000000'

    for ball in balls
      ball.x += ball.xunits
      ball.y += ball.yunits

      context.beginPath()
      context.arc(ball.x,ball.y,ball.radius,0,Math.PI*2,true)
      context.closePath()
      context.fill()

      if ball.x > theCanvas.width || ball.x < 0
        ball.angle = 180 - ball.angle
        updateBall(ball)
      else if ball.y > theCanvas.height || ball.y < 0
        ball.angle = 360 - ball.angle
        updateBall(ball)

  updateBall = (ball) ->
    ball.radians = ball.angle * Math.PI / 180
    ball.xunits = Math.cos(ball.radians) * ball.speed
    ball.yunits = Math.sin(ball.radians) * ball.speed

  formElement = document.getElementById("canvasWidth")
  formElement.addEventListener('change', canvasWidthChanged, false)

  formElement = document.getElementById("canvasHeight")
  formElement.addEventListener('change', canvasHeightChanged, false)

  setInterval(drawScreen,33)

d = new Debugger
canvasApp()