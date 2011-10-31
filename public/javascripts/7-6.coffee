canvasSupport = -> Modernizr.canvas

supportedAudioFormat = (audio) ->
  returnExtention = ""
  if audio.canPlayType("audio/ogg") == "probably" or audio.canPlayType("audio/ogg") == "maybe"
    returnExtention = "ogg"
  else if audio.canPlayType("audio/wav") == "probably" or audio.canPlayType("audio/wav") == "maybe"
    returnExtention = "wav"
  else if audio.canPlayType("audio/mp3") == "probably" or audio.canPlayType("audio/mp3") == "maybe"
    returnExtention = "mp3"
  returnExtention

STATE_INIT    = 10
STATE_LOADING = 20
STATE_RESET   = 30
STATE_PLAYING = 40
appState = STATE_INIT
loadCount = 0
itemsToLoad = 0

SOUND_EXPLODE = "explode1"
SOUND_SHOOT   = "shoot1"
MAX_SOUNDS    = 6
soundPool = new Array()

player = {x:250, y:475}
aliens = new Array()
missiles = new Array()

ALIEN_START_X = 25
ALIEN_START_Y = 25
ALIEN_ROWS = 3
ALIEN_COLS = 10
ALIEN_SPACING = 40

explodeSound = ''
explodeSound2 = ''
explodeSound3 = ''
shootSound = ''
shootSound2 = ''
shootSound3 = ''
alienImage = new Image()
missileImage = new Image()
playerImage = new Image()


theCanvas = document.getElementById("canvasOne")
context = theCanvas.getContext("2d")

itemLoaded = (event) ->
  loadCount++
  if loadCount >= itemsToLoad
    shootSound.removeEventListener("canplaythrough", itemLoaded, false)
    shootSound2.removeEventListener("canplaythrough", itemLoaded, false)
    shootSound3.removeEventListener("canplaythrough", itemLoaded, false)
    explodeSound.removeEventListener("canplaythrough", itemLoaded, false)
    explodeSound2.removeEventListener("canplaythrough", itemLoaded, false)
    explodeSound3.removeEventListener("canplaythrough", itemLoaded, false)
    soundPool.push({name:"explode1",element:explodeSound, played:false})
    soundPool.push({name:"explode1",element:explodeSound2, played:false})
    soundPool.push({name:"explode1",element:explodeSound3, played:false})
    soundPool.push({name:"shoot1",element:shootSound, played:false})
    soundPool.push({name:"shoot1",element:shootSound2, played:false})
    soundPool.push({name:"shoot1",element:shootSound3, played:false})
    appState = STATE_RESET

initApp = () ->
  loadCount = 0
  itemsToLoad = 9

  explodeSound = document.createElement("audio")
  document.body.appendChild(explodeSound)
  explodeSound.setAttribute("src","/audios/explode1.mp3")
  explodeSound.addEventListener("canplaythrough",itemLoaded,false)

  explodeSound2 = document.createElement("audio")
  document.body.appendChild(explodeSound2)
  explodeSound2.setAttribute("src","/audios/explode1.mp3")
  explodeSound2.addEventListener("canplaythrough",itemLoaded,false)

  explodeSound3 = document.createElement("audio")
  document.body.appendChild(explodeSound3)
  explodeSound3.setAttribute("src","/audios/explode1.mp3")
  explodeSound3.addEventListener("canplaythrough",itemLoaded,false)

  shootSound = document.createElement("audio")
  document.body.appendChild(shootSound)
  shootSound.setAttribute("src","/audios/shoot1.mp3")
  shootSound.addEventListener("canplaythrough",itemLoaded,false)

  shootSound2 = document.createElement("audio")
  document.body.appendChild(shootSound2)
  shootSound2.setAttribute("src","/audios/shoot1.mp3")
  shootSound2.addEventListener("canplaythrough",itemLoaded,false)

  shootSound3 = document.createElement("audio")
  document.body.appendChild(shootSound3)
  shootSound3.setAttribute("src","/audios/shoot1.mp3")
  shootSound3.addEventListener("canplaythrough",itemLoaded,false)

  alienImage = new Image()
  alienImage.onload = itemLoaded
  alienImage.src = "/images/alien.png"
  playerImage = new Image()
  playerImage.onload = itemLoaded
  playerImage.src = "/images/player.png"
  missileImage = new Image()
  missileImage.onload = itemLoaded
  missileImage.src = "/images/missile.png"
  appState = STATE_LOADING


startLevel = () ->
  for r in [0...ALIEN_ROWS]
    for c in [0...ALIEN_COLS]
      aliens.push({speed:2, x:ALIEN_START_X + c * 40, y:ALIEN_START_Y + r * 100, width:alienImage.width, height:alienImage.height})

resetApp = () ->
  playSound(SOUND_EXPLODE,0)
  playSound(SOUND_SHOOT, 0)
  startLevel()
  appState = STATE_PLAYING

drawScreen = ->
  for m,i in missiles.reverse()
    m.y -= m.speed
    m.splice(i,1) if m.y < 0 - m.height
  missiles.reverse()
  for a,i in aliens.reverse()
    a.x += a.speed
    if a.x > (theCanvas.width - a.width) or a.x < 0
      a.speed *= -1
      a.y += 50
    aliens.splice(i,1) if a.y > theCanvas.height
  aliens.reverse()
  missiles.reverse()

  for m,i in missiles.reverse()
    for a,j in aliens.reverse()
      if hitTest(m,a)
        playSound(SOUND_EXPLODE, 0.5)
        missiles.splice(i,1)
        aliens.splice(j,1)
        #`break missile`
    appState = STATE_RESET if aliens.length <= 0

  context.fillStyle = "#ffffff"
  context.fillRect(0, 0, theCanvas.width, theCanvas.height)
  context.strokeStyle = "#eeeeee"
  context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

  context.drawImage(playerImage, player.x, player.y)

  for m in missiles
    context.drawImage(missileImage, m.x,m.y)

  for a in aliens
    context.drawImage(alienImage, a.x, a.y)

  context.fillStyle = "#000000"
  context.fillText("Active Sounds" + soundPool.length, 200, 480)

hitTest = (image1, image2) ->
  r1left = image1.x
  r1top = image1.y
  r1right = image1.x + image1.width
  r1bottom = image1.y + image1.height
  r2left = image2.x
  r2top = image2.y
  r2right = image2.x + image2.width
  r2bottom = image2.y + image2.height
  not (r1left > r2right or r1right < r2left or r1bottom < r2top or r1top > r2bottom)

eventMouseMove = (event) ->
  if event.layerX or event.layerX == 0
    mouseX = event.layerX
    mouseY = event.layerY
  if event.offsetX or event.offsetX == 0
    mouseX = event.offsetX
    mouseY = event.offsetY
  player.x = mouseX
  player.y = mouseY

eventMouseUp = (event) ->
  missiles.push({speed:5, x:player.x + 0.5 * playerImage.width, y:player.y - missileImage.height, width:missileImage.width, height:missileImage.height})
  playSound(SOUND_SHOOT, 0.5)

playSound = (sound,volume) ->
  console.log("playsound")
  soundFound = false
  soundIndex = 0
  if soundPool.length > 0
    while !soundFound and soundIndex < soundPool.length
      tSound = soundPool[soundIndex]
      if (tSound.element.ended or !tSound.played) and tSound.name == sound
        soundFound = true
        tSound.played = true
      else
        soundIndex++
  if soundFound
    tempSound = soundPool[soundIndex].element
    tempSound.volume = volume
    tempSound.play()
  else if soundPool.length < MAX_SOUNDS
    tempSound = document.createElement("audio")
    tempSound.setAttribute("src", sound + "." + audioType)
    tempSound.volume = volume
    tempSound.play()
    soundPool.push({name:sound, element:tempSound, type:audioType, played:true})

run = ->
  switch appState
    when STATE_INIT then initApp()
#    when STATE_LOADING then
    when STATE_RESET then resetApp()
    when STATE_PLAYING then drawScreen()

theCanvas.addEventListener("mouseup",eventMouseUp, false)
theCanvas.addEventListener("mousemove",eventMouseMove, false)

setInterval(run, 33)