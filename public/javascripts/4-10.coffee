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

  mapRows = 10
  mapCols = 10

  tileMap =[
    [32,31,31,31,1,31,31,31,31,32],
    [1,1,1,1,1,1,1,1,1,1],
    [32,1,26,1,26,1,26,1,1,32],
    [32,26,1,1,26,1,1,26,1,32],
    [32,1,1,1,26,26,1,26,1,32],
    [32,1,1,26,1,1,1,26,1,32],
    [32,1,1,1,1,1,1,26,1,32],
    [1,1,26,1,26,1,26,1,1,1],
    [32,1,1,1,1,1,1,1,1,32],
    [32,31,31,31,1,31,31,31,31,32]]

  drawScreen = ->
    for r in [0..9]
      for c in [0..9]
        tileId = tileMap[r][c] - 1
        sourceX = Math.floor(tileId % 8) * 32
        sourceY = Math.floor(tileId / 8) * 32
        context.drawImage(tileSheet, sourceX, sourceY, 32, 32, c*32, r*32, 32, 32)

  eventSheetLoaded = ->
    drawScreen()

  tileSheet = new Image()
  tileSheet.addEventListener('load', eventSheetLoaded, false)
  tileSheet.src = "/images/tank_sheet.png"

d = new Debugger
canvasApp()