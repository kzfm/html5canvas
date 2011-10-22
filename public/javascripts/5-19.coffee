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

  easeValue = .05
  tempSpeed = .5
  tempvelocityx = Math.cos(270*Math.PI/180) * tempSpeed
  tempvelocityy = Math.sin(270*Math.PI/180) * tempSpeed
  p1 = {x:240, y:470}

  ship = {x:p1.x, y:p1.y, velocityx:tempvelocityx, velocityy:tempvelocityy}
  points = new Array()

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)


    ship.velocityx = ship.velocityx + ship.velocityx * easeValue
    ship.velocityy = ship.velocityy + ship.velocityy * easeValue

    ship.x += ship.velocityx
    ship.y += ship.velocityy

    points.push({x:ship.x, y:ship.y})

    for p in points
      context.drawImage(pointImage, p.x, p.y, 1,1)

    context.fillStyle = "#000000"
    context.beginPath()
    context.arc(ship.x, ship.y, 15, 0, Math.PI*2, true)
    context.closePath()
    context.fill()

  setInterval(drawScreen, 33)

d = new Debugger
canvasApp()