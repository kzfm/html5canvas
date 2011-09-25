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
  theCanvas2 = document.getElementById("canvas2")
  context2 = theCanvas2.getContext("2d")

  startUp = ->
    context.drawImage(tileSheet, 0, 0)
    context2.drawImage(theCanvas, 32, 0, 32, 32, 0, 0, 32, 32)

  eventSheetLoaded = ->
    startUp()

  tileSheet = new Image()
  tileSheet.addEventListener('load', eventSheetLoaded, false)
  tileSheet.src = "/images/tank_sheet.png"

d = new Debugger
canvasApp()