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
      context.fillStyle = "red"

      context.shadowOffsetX = 4
      context.shadowOffsetY = 4
      context.shadowColor = "black"
      context.shadowBlur = 4
      context.fillRect(10, 10, 100, 100)

      context.shadowOffsetX = -4
      context.shadowOffsetY = -4
      context.shadowColor = "black"
      context.shadowBlur = 4
      context.fillRect(150, 10, 100, 100)

      context.shadowOffsetX = 10
      context.shadowOffsetY = 10
      context.shadowColor = "rgb(100, 100, 100)"
      context.shadowBlur = 8
      context.arc(200, 300, 100, (Math.PI/180)*0, (Math.PI/180)*360, false)
      context.fill()

  drawScreen()

d = new Debugger
canvasApp()