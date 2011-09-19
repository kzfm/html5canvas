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
    context.rotate(angleInRadians)
    context.fillStyle = "red"
    context.fillRect(100,100,50,50)

  drawScreen()

d = new Debugger
canvasApp()