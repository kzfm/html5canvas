canvasSupport = -> Modernizr.canvas

audioLoaded = (event) -> audioElement.play()

supportedAudioFormat = (audio) ->
  returnExtention = ""
  if audio.canPlayType("audio/ogg") == "probably" or audio.canPlayType("audio/ogg") == "maybe"
    returnExtention = "ogg"
  else if audio.canPlayType("audio/wav") == "probably" or audio.canPlayType("audio/wav") == "maybe"
    returnExtention = "wav"
  else if audio.canPlayType("audio/mp3") == "probably" or audio.canPlayType("audio/mp3") == "maybe"
    returnExtention = "mp3"
  returnExtention

drawScreen = ->
  context.fillStyle = "#ffffaa"
  context.fillRect(0, 0, theCanvas.width, theCanvas.height)
  context.strokeStyle = "#000000"
  context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

  context.fillStyle = "#000000"
  context.fillText("Duration:" + audioElement.duration, 20, 20)
  context.fillText("Current time" + audioElement.currentTime, 20, 40)
  context.fillText("Loop:" + audioElement.loop, 20, 60)
  context.fillText("Autoplay:" + audioElement.autoplay, 20, 80)
  context.fillText("Muted:" + audioElement.muted, 20, 100)
  context.fillText("Controls:" + audioElement.controls, 20, 120)
  context.fillText("Volume:" + audioElement.volume, 20, 140)
  context.fillText("Paused:" + audioElement.poused, 20, 160)
  context.fillText("Ended:" + audioElement.ended, 20, 180)
  context.fillText("Source:" + audioElement.currentSrc, 20, 200)
  context.fillText("Can Play OGG:" + audioElement.canPlayType("audio/ogg"), 20, 220)
  context.fillText("Can Play WAV:" + audioElement.canPlayType("audio/wav"), 20, 240)
  context.fillText("Can Play MP3:" + audioElement.canPlayType("audio/mp3"), 20, 260)

audioElement = document.createElement("audio")
document.body.appendChild(audioElement)
audioType = supportedAudioFormat(audioElement)
audioElement.setAttribute("src", "/audios/audio." + audioType)
audioElement.addEventListener("canplaythrough",audioLoaded, false)

theCanvas = document.getElementById("canvasOne")
context = theCanvas.getContext("2d")

setInterval(drawScreen, 33)