#shipState = 0
FRAME_RATE = 40
intervalTime = 1000 / FRAME_RATE
rotation = 0
x = 50
y = 50

theCanvas = document.getElementById("canvas")
context = theCanvas.getContext("2d")

drawScreen = ->
#  shipState ^= 1

  context.fillStyle = "#000000"
  context.fillRect(0,0,200,200)
  context.fillStyle = "#ffffff"
  context.font = "20px _sans"
  context.textBaseline = "top"
  context.fillText("Player Ship - Static", 0, 180)

  angleInRadians = rotation * Math.PI / 180
  context.save()
  context.setTransform(1,0,0,1,0,0)

  context.translate(x,y)
  context.rotate(angleInRadians)

  context.strokeStyle = "#ffffff"
  context.beginPath()
  context.moveTo(10,0)
  context.lineTo(19,19)
  context.lineTo(10,9)
  context.lineTo(9,9)
  context.lineTo(0,19)
  context.lineTo(9,0)

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
  rotation++

setInterval(drawScreen, intervalTime)