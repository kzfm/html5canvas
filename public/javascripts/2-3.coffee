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
    context.lineJoin = "bevel"
    context.lineCap = "round"
    context.beginPath()
    context.moveTo(0, 0)
    context.lineTo(25, 0)
    context.lineTo(25, 25)
    context.stroke()
    context.closePath()

    context.beginPath()
    context.moveTo(10, 50)
    context.lineTo(35, 50)
    context.lineTo(35, 75)
    context.stroke()
    context.closePath()

    context.lineJoin = "round"
    context.lineCap = "butt"
    context.beginPath()
    context.moveTo(10, 100)
    context.lineTo(35, 100)
    context.lineTo(35, 125)
    context.stroke()
    context.closePath()

  drawScreen()

d = new Debugger
canvasApp()