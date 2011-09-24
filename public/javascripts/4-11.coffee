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

  drawScreen = ->
    context.drawImage(photo, windowX, windowY, windowWidth, windowHeight, 0, 0, windowWidth, windowHeight)

  eventPhotoLoaded = ->
    drawScreen()

  photo = new Image()
  photo.addEventListener('load', eventPhotoLoaded, false)
  photo.src = "/images/agile.jpg"

  windowWidth = 500
  windowHeight = 500
  windowX = 0
  windowY = 0

d = new Debugger
canvasApp()