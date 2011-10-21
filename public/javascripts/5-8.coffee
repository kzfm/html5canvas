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
  numBalls = 50
  maxSize = 12
  minSize = 3
  maxSpeed = maxSize+5
  balls = new Array()

  hitTestCircle = (ball1, ball2) ->
    retval = false
    dx = ball1.nextX - ball2.nextX
    dy = ball1.nextY - ball2.nextY
    distance = dx * dx + dy * dy
    if distance <= (ball1.radius + ball2.radius) * (ball1.radius + ball2.radius)
      retval = true
    retval

  canStartHere = (ball) ->
    retval = true
    #d.log(ball)
    for b in balls
      if hitTestCircle(ball,b)
        retval = false
    retval

  for i in [0..numBalls]
    placeOK = false
    tempRadius = Math.floor(Math.random()*maxSize) + minSize
    while not placeOK
      tempX = tempRadius*3 + (Math.floor(Math.random()*theCanvas.width) - tempRadius*3)
      tempY = tempRadius*3 + (Math.floor(Math.random()*theCanvas.height) - tempRadius*3)
      tempSpeed = maxSpeed - tempRadius
      tempAngle = Math.floor(Math.random()*360)
      tempRadians = tempAngle * Math.PI/ 180
      tempvelocityx = Math.cos(tempRadians) * tempSpeed
      tempvelocityy = Math.sin(tempRadians) * tempSpeed

      tempBall = {X:tempX, Y:tempY, nextX:tempX, nextY:tempY, radius:tempRadius, speed:tempSpeed, angle:tempAngle, velocityx:tempvelocityx, velocityy:tempvelocityy, mass:tempRadius}
      d.log(tempBall)
      placeOK = canStartHere(tempBall)
    balls.push(tempBall)

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)

    update()
    testWalls()
    collide()
    render()

  update = ->
    for ball in balls
      ball.nextX = (ball.X += ball.velocityx)
      ball.nextY = (ball.Y += ball.velocityy)

  testWalls = ->
    for ball in balls
      if ball.nextX + ball.radius > theCanvas.width
        ball.velocityx = ball.velocityx * -1
        ball.nextX = theCanvas.width - ball.radius
      else if ball.nextX - ball.radius < 0
        ball.velocityx = ball.velocityx * -1
        ball.nextX = ball.radius
      else if ball.nextY + ball.radius > theCanvas.height
        ball.velocityy = ball.velocityy * -1
        ball.nextY = theCanvas.height - ball.radius
      else if ball.nextY - ball.radius < 0
        ball.velocityy = ball.velocityy * -1
        ball.nextY = ball.radius

  render = ->
    context.fillStyle = "#00ff00"
    for ball in balls
      ball.X = ball.nextX
      ball.Y = ball.nextY

      context.beginPath()
      context.arc(ball.X, ball.Y, ball.radius, 0, Math.PI*2, true)
      context.closePath()
      context.fill()

  collide = ->
    for ball,i in balls
      for testBall in balls[i+1..]
        if hitTestCircle(ball,testBall)
          collideBalls(ball,testBall)

  collideBalls = (ball1, ball2) ->
    dx = ball1.nextX - ball2.nextX
    dy = ball1.nextY - ball2.nextY

    collisionAngle = Math.atan2(dy,dx)

    speed1 = Math.sqrt(ball1.velocityx * ball1.velocityx + ball1.velocityy * ball1.velocityy)
    speed2 = Math.sqrt(ball2.velocityx * ball2.velocityx + ball2.velocityy * ball2.velocityy)
    direction1 = Math.atan2(ball1.velocityy, ball1.velocityx)
    direction2 = Math.atan2(ball2.velocityy, ball2.velocityx)

    velocityx_1 = speed1 * Math.cos(direction1 - collisionAngle)
    velocityy_1 = speed1 * Math.sin(direction1 - collisionAngle)
    velocityx_2 = speed2 * Math.cos(direction2 - collisionAngle)
    velocityy_2 = speed2 * Math.sin(direction2 - collisionAngle)

    final_velocityx_1 = ((ball1.mass - ball2.mass) * velocityx_1 + (ball2.mass + ball2.mass) * velocityy_2) / (ball1.mass + ball2.mass)
    final_velocityx_2 = ((ball1.mass + ball1.mass) * velocityx_1 + (ball2.mass - ball1.mass) * velocityy_2) / (ball1.mass + ball2.mass)

    final_velocityy_1 = velocityy_1
    final_velocityy_2 = velocityy_2

    ball1.velocityx = Math.cos(collisionAngle) * final_velocityx_1 + Math.cos(collisionAngle + Math.PI/2) * final_velocityy_1
    ball1.velocityy = Math.sin(collisionAngle) * final_velocityx_1 + Math.sin(collisionAngle + Math.PI/2) * final_velocityy_1
    ball2.velocityx = Math.cos(collisionAngle) * final_velocityx_2 + Math.cos(collisionAngle + Math.PI/2) * final_velocityy_2
    ball2.velocityy = Math.sin(collisionAngle) * final_velocityx_2 + Math.sin(collisionAngle + Math.PI/2) * final_velocityy_2

    ball1.nextX = (ball1.nextX += ball1.velocityx)
    ball1.nextY = (ball1.nextY += ball1.velocityy)
    ball2.nextX = (ball2.nextX += ball2.velocityx)
    ball2.nextY = (ball2.nextY += ball2.velocityy)

  setInterval(drawScreen, 33)

d = new Debugger
canvasApp()