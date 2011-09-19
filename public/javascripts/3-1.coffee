class Debugger
  log: (message) ->
    try
      console.log(message)
    catch exception
      return

canvasSupport = -> Modernizr.canvas

canvasApp = ->
  message = "your text"
  fillOrStroke = "fill"
  return if !canvasSupport()

  theCanvas = document.getElementById("canvasOne")
  context = theCanvas.getContext("2d")

  drawScreen = ->
    context.fillStyle = "#ffffaa"
    context.fillRect(0, 0, theCanvas.width, theCanvas.height)

    context.strokeStyle = "#000000"
    context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

    context.font = "50px serif"

    metrics = context.measureText(message)
    textWidth = metrics.width
    xPosition = (theCanvas.width/2) - (textWidth/2)
    yPositon  = (theCanvas.height/2)

    switch fillOrStroke
      when "fill" then context.fillStyle = "#FF0000"; context.fillText(message, xPosition, yPositon)
      when "stroke" then context.strokeStyle = "#FF0000"; context.strokeText(message, xPosition, yPositon)
      when "both"
        context.fillStyle = "#FF0000"
        context.fillText(message, xPosition, yPositon)
        context.strokeStyle = "#000000"
        context.strokeText(message, xPosition, yPositon)

  textBoxChanged = (e) ->
    target = e.target
    message = target.value
    drawScreen()

  fillOrStrokeChanged = (e) ->
    target = e.target
    fillOrStroke = target.value
    drawScreen()

  formElement = document.getElementById("textBox")
  formElement.addEventListener("keyup", textBoxChanged, false)

  formElement = document.getElementById("fillOrStroke")
  formElement.addEventListener("change", fillOrStrokeChanged, false)

  drawScreen()

d = new Debugger
canvasApp()