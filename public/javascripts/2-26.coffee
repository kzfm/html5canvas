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
      fillPattern1 = context.createPattern(fillImg,'no-repeat')
      fillPattern2 = context.createPattern(fillImg,'repeat-x')
      fillPattern3 = context.createPattern(fillImg,'repeat-y')

      context.fillStyle = fillPattern1
      context.fillRect(0, 0, 100, 100)

      context.fillStyle = fillPattern2
      context.fillRect(0, 110, 100, 100)

      context.fillStyle = fillPattern3
      context.fillRect(0, 220, 100, 100)

  drawScreen()

d = new Debugger
canvasApp()