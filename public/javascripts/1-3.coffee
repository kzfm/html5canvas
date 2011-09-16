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
    context.fillStyle = "#ffffaa"
    context.fillRect(0, 0, 500, 300)
    context.fillStyle = "#000000"
    context.font = "20px _sans"
    context.textBaseline = "top"
    context.fillText("Hello World!", 195, 80)

    context.strokeStyle = "#000000"
    context.strokeRect(5, 5, 490, 290)

  drawScreen()

d = new Debugger
canvasApp()