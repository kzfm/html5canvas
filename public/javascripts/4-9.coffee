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
  rotation = 90
  [x,y,dx,dy] = [50,50,1,0]

  drawScreen = ->
    x = x + dx
    y = y + dy

    context.fillStyle = "#aaaaaa"
    context.fillRect(0, 0, 500, 500)

    context.save()
    context.setTransform(1,0,0,1,0,0)

    angleInRadian = rotation * Math.PI / 180
    context.translate(x+16, y+16)
    context.rotate(angleInRadian)

    sourceX = Math.floor(animationFrames[frameIndex] % 8) * 32
    sourceY = Math.floor(animationFrames[frameIndex] / 8) * 32

    context.drawImage(tileSheet,sourceX, sourceY, 32, 32, -16, -16, 32, 32)
    context.restore()

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