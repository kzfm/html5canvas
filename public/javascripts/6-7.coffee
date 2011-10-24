canvasSupport = -> Modernizr.canvas
canvasApp = -> return if not canvasSupport

drawScreen = ->
  context.fillStyle = "#ffffaa"
  context.fillRect(0, 0, theCanvas.width, theCanvas.height)

  context.strokeStyle = "#000000"
  context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

  context.drawImage(videoElement, 85, 30)

  context.fillStyle = "#000000"
  context.fillText("Duration:"+ videoElement.duration, 10, 280)
  context.fillText("Current time:"+ videoElement.currentTime,260,280)
  context.fillText("Loop:" + videoElement.loop, 10, 290)
  context.fillText("AutoPlay:" + videoElement.autoplay, 100, 290)
  context.fillText("Controls:" + videoElement.controls, 260, 290)
  context.fillText("Volume:" + videoElement.volume, 340, 290)

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