canvasSupport = -> Modernizr.canvas

theCanvas = document.getElementById("canvas")
context = theCanvas.getContext("2d")

drawScreen = ->
  context.fillStyle = "#000000"
  context.fillRect(0,0,200,200)
  context.fillStyle = "#ffffff"
  context.font = "20px _sans"
  context.textBaseline = "top"
  context.fillText("Player Ship - Static", 0, 180)

  context.strokeStyle = "#ffffff"
  context.beginPath()
  context.moveTo(10,0)
  context.lineTo(19,19)
  context.lineTo(10,9)
  context.lineTo(9,9)
  context.lineTo(0,19)
  context.lineTo(9,0)

  context.stroke()
  context.closePath()

drawScreen()