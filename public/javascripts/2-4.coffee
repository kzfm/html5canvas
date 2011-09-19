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
    context.lineWidth = 5
    context.beginPath()
    context.arc(100, 100, 20, (Math.PI/180)*0, (Math.PI/180)*360, false)
    context.stroke()
    context.closePath()
  drawScreen()

d = new Debugger
canvasApp()