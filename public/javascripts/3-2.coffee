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
  fontSize = "50"
  fontFace = "serf"
  textFillColor = "#ff0000"
  textBaseline = "middle"
  textAlign = "center"
  fontWeight = "normal"
  fontStyle = "normal"

  return if !canvasSupport()

  theCanvas = document.getElementById("canvasOne")
  context = theCanvas.getContext("2d")

  drawScreen = ->
    context.fillStyle = "#ffffaa"
    context.fillRect(0, 0, theCanvas.width, theCanvas.height)

    context.strokeStyle = "#000000"
    context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

    context.textBaseline = textBaseline
    context.textAlign = textAlign
    context.font = fontWeight + " " + fontStyle + " " + fontSize + "px " + fontFace

    metrics = context.measureText(message)
    textWidth = metrics.width
    xPosition = theCanvas.width/2
    yPositon  = theCanvas.height/2

    switch fillOrStroke
      when "fill" then context.fillStyle = textFillColor; context.fillText(message, xPosition, yPositon)
      when "stroke" then context.strokeStyle = textFillColor; context.strokeText(message, xPosition, yPositon)
      when "both"
        context.fillStyle = textFillColor
        context.fillText(message, xPosition, yPositon)
        context.strokeStyle = "#000000"
        context.strokeText(message, xPosition, yPositon)

  textBoxChanged =       (e) -> message = e.target.value; drawScreen()
  fillOrStrokeChanged =  (e) -> fillOrStroke = e.target.value; drawScreen()
  fontSizeChanged =      (e) -> fontSize = e.target.value; drawScreen()
  textFillColorChanged = (e) -> textFillColor = e.target.value; drawScreen()
  textFontChanged =      (e) -> textFont = e.target.value; drawScreen()
  textBaselineChanged =  (e) -> textBaseline = e.target.value; drawScreen()
  textAlignChanged =     (e) -> textAlign = e.target.value; drawScreen()
  fontWeightChanged =    (e) -> fontWeight = e.target.value; drawScreen()
  fontStyleChanged =     (e) -> fontStyle = e.target.value; drawScreen()

  formElement = document.getElementById("textBox")
  formElement.addEventListener("keyup", textBoxChanged, false)

  formElement = document.getElementById("fillOrStroke")
  formElement.addEventListener("change", fillOrStrokeChanged, false)

  formElement = document.getElementById("fontSize")
  formElement.addEventListener("change", fontSizeChanged, false)

  formElement = document.getElementById("textFillColor")
  formElement.addEventListener("change", textFillColorChanged, false)

  formElement = document.getElementById("textFont")
  formElement.addEventListener("change", textFontChanged, false)

  formElement = document.getElementById("textBaseline")
  formElement.addEventListener("change", textBaselineChanged, false)

  formElement = document.getElementById("textAlign")
  formElement.addEventListener("change", textAlignChanged, false)

  formElement = document.getElementById("fontWeight")
  formElement.addEventListener("change", fontWeightChanged, false)

  formElement = document.getElementById("fontStyle")
  formElement.addEventListener("change", fontStyleChanged, false)

  drawScreen()

d = new Debugger
canvasApp()