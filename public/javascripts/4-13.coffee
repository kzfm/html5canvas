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
    context.drawImage(photo, windowX, windowY, windowWidth, windowHeight, 0, 0, windowWidth*.5, windowHeight*.5)
    windowX += 10
    windowX = photo.width - windowWidth if windowX > photo.width - windowWidth

  startUp = ->
    setInterval(drawScreen, 100)

  eventPhotoLoaded = ->
    startUp()

  photo = new Image()
  photo.addEventListener('load', eventPhotoLoaded, false)
  photo.src = "/images/agile.jpg"

d = new Debugger
canvasApp()