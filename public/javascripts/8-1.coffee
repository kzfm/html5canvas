canvasSupport = -> Modernizr.canvas

theCanvas = document.getElementById("canvas")
context = theCanvas.getContext("2d")

drawScreen = ->
  context.fillStyle = "#ffaaaa"
  context.fillRect(0,0,200,200)
  context.fillStyle = "#000000"
  context.font = "20px _sans"
  context.textBaseline = "top"
  context.fillText("Canvas!", 0, 0)

drawScreen()