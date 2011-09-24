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
  animationFrames = [1,2,3,4,5,6,7,8]
  frameIndex = 0
  [dx,dy,x,y] = [0,-1,50,50]

  drawScreen = ->
    y = y+dy
    x = x+dx
    context.fillStyle = "#aaaaaa"
    context.fillRect(0, 0, 500, 500)
    sourceX = Math.floor(animationFrames[frameIndex] % 8) * 32
    sourceY = Math.floor(animationFrames[frameIndex] / 8) * 32
    context.drawImage(tileSheet,sourceX, sourceY, 32, 32, x, y, 32, 32)

    frameIndex++
    frameIndex = 0 if frameIndex == animationFrames.length

  startUp = ->
    setInterval(drawScreen, 100)

  eventShipLoaded = ->
    startUp()

  tileSheet = new Image()
  tileSheet.addEventListener('load', eventShipLoaded, false)
  tileSheet.src = "/images/tank_sheet.png"

d = new Debugger
canvasApp()