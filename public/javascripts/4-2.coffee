class Debugger
  log: (message) ->
    try
      console.log(message)
    catch exception
      return

canvasSupport = -> Modernizr.canvas

canvasApp = ->
  return if !canvasSupport()

  theCanvas = document.getElementById("canvasOne")
  context = theCanvas.getContext("2d")

  d.log("Drawing Canvas")

  drawScreen = ->
    context.drawImage(spaceShip, 0, 0)
    context.drawImage(spaceShip, 0, 34, 32, 32)
    context.drawImage(spaceShip, 0, 68, 64, 64)
    context.drawImage(spaceShip, 0, 140, 16, 16)

  eventShipLoaded = ->
    drawScreen()

  spaceShip = new Image()
  spaceShip.addEventListener('load', eventShipLoaded, false)
  spaceShip.src = "/images/ship1.png"



d = new Debugger
canvasApp()