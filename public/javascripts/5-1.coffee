class Debugger
  log: (message) ->
    try
      console.log(message)
    catch exception
      return

canvasSupport = -> Modernizr.canvas

canvasApp = ->
  return if !canvasSupport()

  theCanvas = document.getElementById("canvas")
  context = theCanvas.getContext("2d")

  speed = 5
  y = 10
  x = 250

  drawScreen = ->
    context.fillStyle = '#eeeeee'
    context.fillRect(0,0,theCanvas.width,theCanvas.height)

    context.strokeStyle = '#000000'
    context.strokeRect(1,1,theCanvas.width-2,theCanvas.height-2)

    y += speed

    context.fillStyle = '#000000'
    context.beginPath()
    context.arc(x,y,15,0,Math.PI*2,true)
    context.closePath()
    context.fill()


  setInterval(drawScreen,33)

d = new Debugger
canvasApp()