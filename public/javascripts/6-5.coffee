updateLoadingStatus = ->
  loadingStatus = document.getElementById("loadingStatus")
  videoElement = document.getElementById("theVideo")
  percentLoaded = parseInt((videoElement.buffered.end(0) / videoElement.duration) * 100)
  document.getElementById("loadingStatus").innerHTML = percentLoaded + '%'

playVideo = ->
  videoElement = document.getElementById("theVideo")
  videoElement.play()

videoElement = document.getElementById("theVideo")
videoElement.addEventListener('progress', updateLoadingStatus, false)
videoElement.addEventListener('canplaythrough', playVideo, false)