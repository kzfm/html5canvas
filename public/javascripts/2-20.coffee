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
    gr = context.createLinearGradient(0, 0, 100, 100)
    gr.addColorStop(0, 'rgb(255,0,0)')
    gr.addColorStop(0.5, 'rgb(0,255,0)')
    gr.addColorStop(1, 'rgb(255,0,0)')

    context.fillStyle = gr
    context.fillRect(0, 0, 100, 100)
  drawScreen()

d = new Debugger
canvasApp()