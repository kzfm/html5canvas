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
  currentScale = .5
  minScale = .2
  maxScale = 3
  scaleIncrement = .1

  document.onkeydown = (e) ->
    e = e ? e : window.event
    d.log("e.keyCode: " + e.keyCode)

    switch e.keyCode
      when 38 then windowY -= 10; windowY = 0 if windowY < 0
      when 40 then windowY += 10; windowY = photo.height - windowHeight if windowY > photo.height - windowHeight
      when 37 then windowX -= 10; windowX = 0 if windowX < 0
      when 39 then windowX += 10; windowX = photo.width - windowWidth if windowX > photo.width - windowWidth
      when 189 then currentScale -= scaleIncrement; currentScale = minScale if currentScale < minScale
      when 187 then currentScale += scaleIncrement; currentScale = maxScale if currentScale > maxScale

  drawScreen = ->
    context.drawImage(photo, windowX, windowY, windowWidth*currentScale, windowHeight*currentScale, 0, 0, windowWidth, windowHeight)

  startUp = ->
    setInterval(drawScreen, 100)

  eventPhotoLoaded = ->
    startUp()

  photo = new Image()
  photo.addEventListener('load', eventPhotoLoaded, false)
  photo.src = "/images/agile.jpg"

d = new Debugger
canvasApp()