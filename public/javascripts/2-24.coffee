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
    gr = context.createRadialGradient(50,50,25,100,100,100)
    gr.addColorStop(0, 'rgb(255,0,0)')
    gr.addColorStop(0.5, 'rgb(0,255,0)')
    gr.addColorStop(1, 'rgb(255,0,0)')

    context.strokeStyle = gr
    context.arc(100, 100, 50, (Math.PI/180)*0, (Math.PI/180)*360, false)
    context.stroke()
  drawScreen()

d = new Debugger
canvasApp()