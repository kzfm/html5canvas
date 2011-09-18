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
    context.fillStyle = "#000000"
    context.strokeStyle = "#ff00ff"
    context.linewidth = 2
    context.fillRect(10, 10, 40, 40)
    context.strokeRect(0, 0, 60, 60)
    context.clearRect(20, 20, 20, 20)
  drawScreen()

d = new Debugger
canvasApp()