canvasSupport = -> Modernizr.canvas
canvasApp = -> return if not canvasSupport

rotation = 0

drawScreen = ->
  context.fillStyle = "#ffffaa"
  context.fillRect(0, 0, theCanvas.width, theCanvas.height)

  context.strokeStyle = "#000000"
  context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

  context.save()
  context.setTransform(1,0,0,1,0,0)

  angleIntRadius = rotation * Math.PI/180
  x = 100
  y = 100
  videoWidth = 320
  videoHeight = 240
  context.translate(x+.5*videoWidth, y+.5*videoHeight)
  context.rotate(angleIntRadius)
  context.drawImage(videoElement, -0.5*videoWidth, -0.5*videoHeight)
  context.restore()
  rotation += 1

videoLoaded = (event) -> canvasApp()

supportedVideoFormat = (video) ->
  returnExtension =""
  if video.canPlayType("video/ogg") == "probably" or video.canPlayType("video/ogg") == "maybe"
    returnExtension = "ogv"
  else if video.canPlayType("video/webm") == "probably" or video.canPlayType("video/webm") == "maybe"
    returnExtension = "webm"
  else if video.canPlayType("video/mp4") == "probably" or video.canPlayType("video/mp4") == "maybe"
    returnExtension = "mp4"
  returnExtension

videoElement = document.createElement('video')
videoDiv = document.createElement('div')
document.body.appendChild(videoDiv)
videoDiv.appendChild(videoElement)
videoDiv.setAttribute("style","display:none;")
videoType = supportedVideoFormat(videoElement)

console.log(videoType)
videoElement.setAttribute("src","/videos/sample." + videoType)
videoElement.addEventListener("canplaythrough", videoLoaded, false)

theCanvas = document.getElementById("canvasOne")
context = theCanvas.getContext("2d")

videoElement.play()
setInterval(drawScreen, 33)