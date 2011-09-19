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
    angleInRadians = 45 * Math.PI / 180
    [x, y, width, height] = [50, 100, 40, 40]
    context.translate(x+.5*width, y+.5*height)
    context.rotate(angleInRadians)
    context.fillStyle = "red"
    context.fillRect(-.5*width, -.5*height, width, height)

    context.setTransform(1,0,0,1,0,0)
    angleInRadians = 75 * Math.PI / 180
    [x, y, width, height] = [100, 100, 40, 40]
    context.translate(x+.5*width, y+.5*height)
    context.rotate(angleInRadians)
    context.fillStyle = "red"
    context.fillRect(-.5*width, -.5*height, width, height)

    context.setTransform(1,0,0,1,0,0)
    angleInRadians = 90 * Math.PI / 180
    [x, y, width, height] = [150, 100, 40, 40]
    context.translate(x+.5*width, y+.5*height)
    context.rotate(angleInRadians)
    context.fillStyle = "red"
    context.fillRect(-.5*width, -.5*height, width, height)

    context.setTransform(1,0,0,1,0,0)
    angleInRadians = 120 * Math.PI / 180
    [x, y, width, height] = [200, 100, 40, 40]
    context.translate(x+.5*width, y+.5*height)
    context.rotate(angleInRadians)
    context.fillStyle = "red"
    context.fillRect(-.5*width, -.5*height, width, height)

  drawScreen()

d = new Debugger
canvasApp()