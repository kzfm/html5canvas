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

  drawScreen = (center) ->

    drawText = (message, xpos, ypos, fontsize, color) ->
      fontSize = fontsize
      fontFace = "fancy"
      textFillColor = color || "#ffffff"
      textBaseline = "middle"
      textAlign = "center"
      fontWeight = "bold"
      fontStyle = "normal"

      context.textBaseline = textBaseline
      context.textAlign = textAlign
      context.font = fontWeight + " " + fontStyle + " " + fontSize + "px " + fontFace
      context.fillStyle = textFillColor

      context.fillText(message, xpos, ypos)
      context.strokeStyle = "#000000"
      context.strokeText(message, xpos, ypos)

    context.setTransform(1,0,0,1,0,0)
    total = 94 + 97 + 78 + 78
    rad = (Math.PI/180)*360

    context.fillStyle = "#fe8d8f"
    context.arc(200, 200, 200, rad*0, rad*(97/total), false)
    context.lineTo(center.x, center.y)
    context.fill()

    context.beginPath()
    context.fillStyle = "#a9a6de"
    context.arc(200, 200, 200, rad*(97/total), rad*((97+78)/total), false)
    context.lineTo(center.x, center.y)

    context.fill()
    context.beginPath()
    context.fillStyle = "#8db5e8"
    context.arc(200, 200, 200, rad*((97+78)/total), rad*((97+78+78)/total), false)
    context.lineTo(center.x, center.y)
    context.fill()

    context.beginPath()
    context.fillStyle = "#a3d9ff"
    context.arc(200, 200, 200, rad*((97+78+78)/total), rad, false)
    context.lineTo(center.x, center.y)
    context.fill()

    context.beginPath()
    context.strokeStyle = "#444444"
    context.arc(200, 200, 200, 0, rad, false)
    context.stroke()

    drawText("10-20代", 250, 230, 30)
    drawText("97人", 300, 300, 80, "#f5fe7d")

    drawText("30代", 50, 230, 30)
    drawText("78人", 80, 280, 50, "#a3d2a0")

    drawText("40代", 80, 30, 30)
    drawText("78人", 100, 80, 50, "#a3d2a0")

    drawText("50代", 280, 30, 30)
    drawText("94人", 300, 80, 50, "#a3d2a0")

#  drawScreen({ x: 200, y:200 })

  drawScreen({ x: 180, y:120 })

d = new Debugger
canvasApp()