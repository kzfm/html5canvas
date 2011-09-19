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
    context.setTransform(1,0,0,1,0,0)
    x = 100; y = 100; width = 50; height = 50
    context.translate(x+.5*width, y+.5*height)
    context.scale(2,2)
    context.fillStyle = "red"
    context.fillRect(-.5*width, -.5*height, width, height)

  drawScreen()

d = new Debugger
canvasApp()