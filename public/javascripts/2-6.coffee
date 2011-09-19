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
    context.fillRect(10, 10, 200, 200)

    context.fillStyle = "red"
    context.fillRect(1, 1, 50, 50)

    context.globalCompositeOperation = "source-over"
    context.fillRect(60, 1, 50, 50)

    context.globalCompositeOperation = "destination-atop"
    context.fillRect(1, 60, 50, 50)

    context.globalAlpha = .5

    context.globalCompositeOperation = "source-atop"
    context.fillRect(60, 60, 50, 50)

  drawScreen()

d = new Debugger
canvasApp()