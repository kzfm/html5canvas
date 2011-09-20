class Debugger
  log: (message) ->
    try
      console.log(message)
    catch exception
      return

canvasSupport = -> Modernizr.canvas

canvasApp = ->
  message = "your text"
  fontSize = "50"
  fontFace = "serif"
  textFillColor = "#ff0000"
  textAlpha = 1
  shadowX = 1
  shadowY = 1
  shadowBlur = 1
  shadowColor = "#707070"
  textBaseline = "middle"
  textAlign = "center"
  fillOrStroke = "fill"
  fontWeight = "normal"
  fontStyle = "normal"
  fillType = "colorFill"
  textFillColor2 = "#000000"
  pattern = new Image()
  pattern.src = "/images/fill_20x20.gif"

  return if !canvasSupport()

  theCanvas = document.getElementById("canvasOne")
  context = theCanvas.getContext("2d")

  drawScreen = ->
    context.globalAlpha = 1
    context.shadowColor = "#707070"
    context.shadowOffsetX = 0
    context.shadowOffsetY = 0
    context.shadowBlur = 0
    context.fillStyle = "#ffffaa"
    context.fillRect(0, 0, theCanvas.width, theCanvas.height)

    context.strokeStyle = "#000000"
    context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

    context.textBaseline = textBaseline
    context.textAlign = textAlign
    context.font = fontWeight + " " + fontStyle + " " + fontSize + "px " + fontFace
    context.shadowColor = shadowColor
    context.shadowOffsetX = shadowX
    context.shadowOffsetY = shadowY
    context.shadowBlur = shadowBlur
    context.globalAlpha = textAlpha

    xPosition = theCanvas.width/2
    yPosition  = theCanvas.height/2

    metrics = context.measureText(message)
    textWidth = metrics.width

    tempColor
    if fillType == "colorFill"
      tempColor = textFillColor
    else if fillType == "linearGradient"
      gradient = context.createLinearGradient(xPosition - textWidth/2, yPosition, textWidth, yPosition)
      gradient.addColorStop(0, textFillColor)
      gradient.addColorStop(0.6, textFillColor2)
      tempColor = gradient
    else if fillType == "radialGradient"
      gradient = context.createRadialGradient(xPosition, yPosition, fontSize, xPosition+textWidth, yPosition, 1)
      gradient.addColorStop(0, textFillColor)
      gradient.addColorStop(0.6, textFillColor2)
      tempColor = gradient
    else if fillType == "pattern"
      tempColor = context.createPattern(pattern,"repeat")
    else
      tempColor = textFillColor

    switch fillOrStroke
      when "fill" then context.fillStyle = tempColor; context.fillText(message, xPosition, yPosition)
      when "stroke" then context.strokeStyle = tempColor; context.strokeText(message, xPosition, yPosition)
      when "both"
        context.fillStyle = tempColor
        context.fillText(message, xPosition, yPosition)
        context.strokeStyle = "#000000"
        context.strokeText(message, xPosition, yPosition)

  textBoxChanged =       (e) -> message = e.target.value; drawScreen()
  textBaselineChanged =  (e) -> textBaseline = e.target.value; drawScreen()
  textAlignChanged =     (e) -> textAlign = e.target.value; drawScreen()
  fillOrStrokeChanged =  (e) -> fillOrStroke = e.target.value; drawScreen()
  fontSizeChanged =      (e) -> fontSize = e.target.value; drawScreen()
  textFillColorChanged = (e) -> textFillColor = "#" + e.target.value; drawScreen()
  textFontChanged =      (e) -> fontFace = e.target.value; drawScreen()
  fontWeightChanged =    (e) -> fontWeight = e.target.value; drawScreen()
  fontStyleChanged =     (e) -> fontStyle = e.target.value; drawScreen()
  shadowXChanged =       (e) -> shadowX = e.target.value; drawScreen()
  shadowYChanged =       (e) -> shadowY = e.target.value; drawScreen()
  shadowBlurChanged =    (e) -> shadowBlur = e.target.value; drawScreen()
  shadowColorChanged =   (e) -> shadowColor = e.target.value; drawScreen()
  textAlphaChanged =     (e) -> textAlpha = e.target.value; drawScreen()
  textFillColor2Changed = (e) ->  textFillColor2 = "#" + e.target.value; drawScreen()
  fillTypeChanged =      (e) ->  fillType = e.target.value; drawScreen()
  canvasWidthChanged =   (e) ->  theCanvas.width = e.target.value; drawScreen()
  canvasHeightChanged =  (e) ->  theCanvas.height = e.target.value; drawScreen()
  canvasStyleSizeChanged = (e) ->
    styleWidth  = document.getElementById("canvasStyleWidth")
    styleHeight = document.getElementById("canvasStyleHeight")
    styleValue = "width:" + styleWidth.value + "px; height:" + styleHeight.value +"px;"
    theCanvas.setAttribute("style", styleValue)
    drawScreen()
  createImageDataPressed = (e) ->
    imageDataDisplay = document.getElementById("imageDataDisplay")
    imageDataDisplay.value = theCanvas.toDataURL()
    window.open(imageDataDisplay.value, "canvasImage", "left=0,top=0,width=" +
    theCanvas.width + ",height=" + theCanvas.height + ",toolbar=0,resizable=0")

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

  formElement = document.getElementById("shadowX")
  formElement.addEventListener("change", shadowXChanged, false)

  formElement = document.getElementById("shadowY")
  formElement.addEventListener("change", shadowYChanged, false)

  formElement = document.getElementById("shadowBlur")
  formElement.addEventListener("change", shadowBlurChanged, false)

  formElement = document.getElementById("shadowColor")
  formElement.addEventListener("change", shadowColorChanged, false)

  formElement = document.getElementById("textAlpha")
  formElement.addEventListener("change", textAlphaChanged, false)

  formElement = document.getElementById("textFillColor2")
  formElement.addEventListener("change", textFillColor2Changed, false)

  formElement = document.getElementById("fillType")
  formElement.addEventListener("change", fillTypeChanged, false)

  formElement = document.getElementById("canvasWidth")
  formElement.addEventListener("change", canvasWidthChanged, false)

  formElement = document.getElementById("canvasHeight")
  formElement.addEventListener("change", canvasHeightChanged, false)

  formElement = document.getElementById("canvasStyleWidth")
  formElement.addEventListener("change", canvasStyleSizeChanged, false)

  formElement = document.getElementById("canvasStyleHeight")
  formElement.addEventListener("change", canvasStyleSizeChanged, false)

  formElement = document.getElementById("createImageData")
  formElement.addEventListener("click", createImageDataPressed, false)

  drawScreen()

d = new Debugger
canvasApp()