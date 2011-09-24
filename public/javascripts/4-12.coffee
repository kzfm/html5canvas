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

  windowWidth = 500
  windowHeight = 500
  windowX = 0
  windowY = 0

  drawScreen = ->
    context.drawImage(photo, windowX, windowY, windowWidth, windowHeight, 0, 0, windowWidth, windowHeight)
    windowX += 1
    windowX = photo.width - windowWidth if windowX > photo.width - windowWidth

  startUp = ->
    setInterval(drawScreen, 10)

  eventPhotoLoaded = ->
    startUp()

  photo = new Image()
  photo.addEventListener('load', eventPhotoLoaded, false)
  photo.src = "/images/agile.jpg"

d = new Debugger
canvasApp()