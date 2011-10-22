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
  p1 = {x:240, y:-20}
  p2 = {x:240, y:470}

  ship = {x:p1.x, y:p1.y, endx:p2.x, endy:p2.y, velocityx:0, velocityy:0}
  points = new Array()

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)

    dx = ship.endx - ship.x
    dy = ship.endy - ship.y

    ship.velocityx = dx * easeValue
    ship.velocityy = dy * easeValue

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