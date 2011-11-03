#shipState = 0
FRAME_RATE = 40
intervalTime = 1000 / FRAME_RATE
#rotation = 0
x = 50
y = 50
width = 20
height = 20
alpha = 0

theCanvas = document.getElementById("canvas")
context = theCanvas.getContext("2d")

drawScreen = ->
#  shipState ^= 1

  context.globalAlpha = 1
  context.fillStyle = "#000000"
  context.fillRect(0,0,200,200)
  context.fillStyle = "#ffffff"
  context.font = "20px _sans"
  context.textBaseline = "top"
  context.fillText("Player Ship - Static", 0, 180)
  context.globalAlpha = alpha
  #angleInRadians = rotation * Math.PI / 180
  context.save()
  context.setTransform(1,0,0,1,0,0)

  context.translate(x+.5*width,y+.5*height)
  #context.rotate(angleInRadians)

  context.strokeStyle = "#ffffff"
  context.beginPath()
  context.moveTo(0,-10)
  context.lineTo(9,9)
  context.lineTo(0,-1)
  context.lineTo(-1,-1)
  context.lineTo(-10,9)
  context.lineTo(-1,-10)

#  if shipState == 1
#    context.moveTo(8,13)
#    context.lineTo(11,13)
#    context.moveTo(9,14)
#    context.lineTo(9,18)
#    context.moveTo(10,14)
#    context.lineTo(10,18)

  context.stroke()
  context.closePath()

  context.restore()
  if alpha > 1 then alpha = 0 else alpha += 0.01
  #rotation++

setInterval(drawScreen, intervalTime)