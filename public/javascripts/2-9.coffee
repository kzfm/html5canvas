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
    context.fillStyle = "black"
    context.fillRect(20,20,25,25)

    context.setTransform(1,0,0,1,0,0)
    angleInRadians = 45 * Math.PI / 180
    [x, y, width, height] = [100, 100, 50, 50]
    context.translate(x+.5*width, y+.5*height)
    context.rotate(angleInRadians)
    context.fillStyle = "red"
    context.fillRect(-.5*width, -.5*height, width, height)

  drawScreen()

d = new Debugger
canvasApp()