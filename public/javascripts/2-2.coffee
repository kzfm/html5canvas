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
    context.strokeStyle = "black"
    context.lineWidth = 10
    context.lineCap = "square"
    context.beginPath()
    context.moveTo(20, 0)
    context.lineTo(100, 0)
    context.stroke()
    context.closePath()
  drawScreen()

d = new Debugger
canvasApp()