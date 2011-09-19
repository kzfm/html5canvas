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
    fillImg = new Image()
    fillImg.src = "images/fill_20x20.gif"
    fillImg.onload = ->
      fillPattern = context.createPattern(fillImg,'repeat')
      context.fillStyle = fillPattern
      context.fillRect(0, 0, 200, 200)
  drawScreen()

d = new Debugger
canvasApp()