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

  mouseX = 0
  mouseY = 0
  imageData = context.createImageData(32, 32)

  drawTileSheet = ->
    context.drawImage(tileSheet,0,0)

  highlightTile = (tileId, x, y) ->
    context.fillStyle = "#aaaaaa"
    context.fillRect(0,0,256,128)
    drawTileSheet()

    imageData = context.getImageData(x,y,32,32)
    for j in (x for x in [3...imageData.data.length] by 4)
      imageData.data[j] = 128

    d.log("tileId: " + tileId)
    startX = Math.floor(tileId % 8) * 32
    startY = Math.floor(tileId / 8) * 32
    context.strokeStyle = "red"
    context.strokeRect(startX, startY, 32, 32)

  onMouseMove = (e) ->
    mouseX = e.clientX - 50
    mouseY = e.clientY - 150

  onMouseClick = (e) ->
    d.log("click: " + mouseX + "," + mouseY)
    if mouseY < 128
      col = Math.floor(mouseX / 32)
      row = Math.floor(mouseY / 32)
      tileId = (row * 7) + (col+row)
      highlightTile(tileId, col*32, row*32)
    else
      col = Math.floor(mouseX / 32)
      row = Math.floor(mouseY / 32)
      context.putImageData(imageData, col*32, row*32)

  startUp = ->
    context.fillStyle = "#aaaaaa"
    context.fillRect(0,0,256,256)
    drawTileSheet()

  eventPhotoLoaded = ->
    startUp()

  tileSheet = new Image()
  tileSheet.addEventListener('load', eventPhotoLoaded, false)
  tileSheet.src = "/images/tank_sheet.png"

  theCanvas.addEventListener("mousemove", onMouseMove, false)
  theCanvas.addEventListener("click", onMouseClick, false)

d = new Debugger
canvasApp()