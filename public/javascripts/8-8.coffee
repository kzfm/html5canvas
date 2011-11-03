#shipState = 0
FRAME_RATE = 40
intervalTime = 1000 / FRAME_RATE
rotation = 0
x = 50
y = 50
facingX = 0
facingY = 0
movingX = 0
movingY = 0
width = 20
height = 20
rotationalVelocity = 5
thrustAcceleration = .03
keyPressList = []

theCanvas = document.getElementById("canvas")
context = theCanvas.getContext("2d")

drawScreen = ->
  if keyPressList[38] == true
    angleInRadians = rotation * Math.PI / 180
    facingX = Math.cos(angleInRadians)
    facingY = Math.sin(angleInRadians)

    movingX = movingX + thrustAcceleration * facingX
    movingY = movingY + thrustAcceleration * facingY

  if keyPressList[37] == true
    rotation -= rotationalVelocity

  if keyPressList[39] == true
    rotation += rotationalVelocity

  x += movingX
  y += movingY

  context.fillStyle = "#000000"
  context.fillRect(0,0,200,200)
  context.fillStyle = "#ffffff"
  context.font = "20px _sans"
  context.textBaseline = "top"
  context.fillText("Player Ship - Static", 0, 180)
  angleInRadians = rotation * Math.PI /180
  context.save()
  context.setTransform(1,0,0,1,0,0)

  context.translate(x+.5*width,y+.5*height)
  context.rotate(angleInRadians)

  context.strokeStyle = "#ffffff"
  context.beginPath()
  context.moveTo(-10,-10)
  context.lineTo(10,0)
  context.moveTo(10,1)
  context.lineTo(-10,10)
  context.lineTo(1,1)
  context.moveTo(1,-1)
  context.lineTo(-10,-10)

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

document.onkeydown = (e) ->
  e = if e then e else window.event
  keyPressList[e.keyCode] = true

document.onkeyup = (e) ->
  e = if e then e else window.event
  keyPressList[e.keyCode] = false

setInterval(drawScreen, intervalTime)