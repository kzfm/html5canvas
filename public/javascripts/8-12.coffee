GAME_STATE_TITLE = 0
GAME_STATE_NEW_GAME = 1
GAME_STATE_NEW_LEVEL = 2
GAME_STATE_PLAYER_START = 3
GAME_STATE_PLAY_LEVEL = 4
GAME_STATE_PLAYER_DIE = 5
GAME_STATE_GAME_OVER = 6

currentGameState = 0
currentGameStateFunction = null

titleStarted = false
gameOverStarted = false

score = 0
level = 0
extraShipAtEach = 10000
extraShipEarned = 0
playerShips = 3

xMin = 0
xMax = 400
yMin = 0
yMax = 400

bigRockScore = 50
medRockScore = 75
smlRockScore = 100
saucerScore = 300

ROCK_SCALE_LARGE = 1
ROCK_SCALE_MEDIUM = 2
ROCK_SCALE_SMALL = 3

player = {}
rocks = []
saucers = []
playerMissiles = []
particles = []
saucerMissiles = []

levelRockMaxDpeedAdjust = 1
levelSaucerMax = 1
levelSaucerOccurenceRate = 25
levelSaucerSpeed = 1
levelSaucerFireDelay = 300
levelSaucerFireRate = 30
levelSaucerMissileSpeed = 1

#FRAME_RATE = 40
#intervalTime = 1000 / FRAME_RATE
#rotation = 0
#x = 50
#y = 50
#facingX = 0
#facingY = 0
#movingX = 0
#movingY = 0
#width = 20
#height = 20
#rotationalVelocity = 5
#thrustAcceleration = .03

keyPressList = []
runGame = () -> currentGameStateFunction()

switchGameState = (newState) ->
  currentGameState = newState
  switch currentGameState
    when GAME_STATE_TITLE        then currentGameStateFunction = gameStateTitle
    when GAME_STATE_NEW_GAME     then currentGameStateFunction = gameStateNewGame
    when GAME_STATE_NEW_LEVEL    then currentGameStateFunction = gameStateNewLevel
    when GAME_STATE_PLAYER_START then currentGameStateFunction = gameStatePlayerStart
    when GAME_STATE_PLAY_LEVEL   then currentGameStateFunction = gameStatePlayLevel
    when GAME_STATE_DIE          then currentGameStateFunction = gameStatePlayerDie
    when GAME_STATE_GAME_OVER    then currentGameStateFunction = gameStateGameOver

gameStateTitle = () ->
  if titleStarted != true
    fillBackground()
    setTextStyle()
    context.fillText("Geo Blaster Basic", 130, 70)
    context.fillText("Press Space To Play", 120, 140)
  else
    if keyPressList[32] == true
      console.log("space pressed")
      switchGameState(GAME_STATE_NEW_GAME)
      titleStarted = false

gameStateNewGame = () ->
  cosole.log("gameStateNewGame")
  level = 0
  score = 0
  playerShips = 3
  player.maxVelocity = 5
  player.width = 20
  player.height = 20
  player.halfWidth = 10
  player.halfHeight = 10
  player.rotationalVelocity = 5
  player.thrustAcceleration = 0.05
  player.missileFrameDelay = 5
  player.thrust = false
  fillBackground()
  renderScoreBoard()
  switchGameState(GAME_STATE_NEW_LEVEL)

gameStateNewLevel = () ->
  rocks = []
  saucers = []
  playerMissiles = []
  particles = []
  saucerMissiles = []
  level++

  levelRockMaxSpeedAdjust = level * 0.25
  levelRockMaxSpeed = 3 if levelRockMaxSpeed > 3

  levelSaucerMax = 1 + Math.floor(level/10)
  levelSaucerMax = 5 if levelSaucerMax > 5

  levelSaucerOccurrenceRate = 10 + 3 * level
  levelSaucerOccurrenceRate = 35 if levelSaucerOccurrenceRate > 35

  levelSaucerSpeed = 1 + 0.5 * level
  levelSaucerSpeed = 5 if levelSaucerSpeed > 5

  levelSaucerFireDelay = 120 - 10 * level
  levelSaucerFireDelay = 20 if levelSaucerFireDelay < 20

  levelSaucerFireRate = 20 + 3 * level
  levelSaucerFireRate = 50 if levelSaucerFireRate > 50

  levelSaucerMissileSpeed = 1 + 0.2 * level
  levelSaucerMissileSpeed = 4 if levelSaucerMissileSpeed > 4

  for c in [0...level+3]
    newRock = {}
    newRock.scale = 1
    newRock.width = 50
    newRock.height = 50
    newRock.halfWidth = 25
    newRock.halfHeight = 25
    newRock.x = Math.floor(Math.random()*50)
    newRock.y = Math.flooor(Math.random()*50)
    newRock.dx = Math.random()*2 + levelRockMaxSpeedAdjust
    newRock.dx *= -1 if Math.random() < 0.5
    newRock.dy = Math.random()*2 + levelRockMaxSpeedAdjust
    newRock.dy *= -1 if Math.random() < 0.5
    newRock.rotationInc = Math.random()*5 + 1
    newRock.rotationInc *= -1 if Math.random() < 0.5

    newRock.scoreValue = bigRockScore
    newRock.rotation = 0
    rocks.push(newRock)

  resetPlayer()
  switchGameState(GAME_STATE_PLAYER_START)

gameStatePlayerStart = () ->
  fillBackground()
  renderScoreBoard()
  if player.alpha < 1
    player.alpha += 0.02
    context.globalAlpha = player.alpha
  else
    switchGameState(GAME_STATE_PLAY_LEVEL)
  renderPlayerShip(player.x, player.y, 270, 1)
  context.globalAlpha = 1
  updateRocks()
  renderRocks()

gameStatePlayLevel = () ->
  checkKeys()
  update()
  render()
  checkCollisions()
  checkForExtraShip()
  checkForEndOfLevel()
  frameRateCounter.countFrames()

resetPlayer = () ->
  player.rotation = 270
  player.x = 0.5 * xMax
  player.y = 0.5 * yMax
  player.facingX = 0
  player.facingY = 0
  player.movingX = 0
  player.movingY = 0
  player.alpha = 0
  player.missileFrameCount = 0

checkForExtraShip = () ->
  if Math.floor(score / extraShipAtEach) > extraShipEarned
    playerShips++
    extraShipEarned++

checkForEndOfLevel = () ->
  switchGameState(GAME_STATE_NEW_LEVEL) if rocks.length == 0

gameStatePlayerDie = () ->
  if particles.length > 0 || playerMissiles.length > 0
    fillBackground()
    renderScoreBoard()
    updateRocks()
    updateSaucers()
    updateParticles()
    updateSaucerMissiles()
    updatePlayerMissiles()
    renderRocks()
    renderSaucers()
    renderParticles()
    renderSaucerMissiles()
    renderPlayerMissiles()
    frameRateCounter.countFrames()
  else
    playerShips--
    if playerShips < 1
      switchGameState(GAME_STATE_GAME_OVER)
    else
      resetPlayer()
      switchGameState(GAME_STATE_PLAYER_START)

gameStateGameOver = () ->
  if gameOverStarted != true
    fillBackground()
    renderScoreBoard()
    setTextStyle()
    context.fillText("Game Over!", 150, 70)
    context.fillText("Press Space To Play", 120, 140)
    gameOverStarted = true
  else
    if keyPressList[32] == true
      switchGameState(GAME_STATE_TITLE)
      gameOverStarted = false

fillBackground = () ->
  context.fillStyle = "#000000"
  context.fillRect(xMin, yMin, xMax, yMax)

setTextStyle = () ->
  context.fillStyle = "#ffffff"
  context.font = "15px _sans"
  context.textBaseline = "top"

renderScoreBoard = () ->
  context.fillStyle = "#ffffff"
  context.fillText("Score " + score, 10, 20)
  renderPlayerShip(200, 16, 270, 0.75)
  context.fillText("X " + playerShips,220, 20)
  context.fillText("FPS: " frameRateCounter.lastFrameCount, 300, 20)

checkKeys = () ->
  if keyPressList[38] == true
    angleInRadians = player.rotation * Math.PI / 180
    player.facingX = Math.cos(angleInRadians)
    player.facingY = Math.sin(angleInRadians)

    movingXNew = player.movingX + player.thrustAcceleration * player.facingX
    movingYNew = player.movingY + player.thrustAcceleration * player.facingY

    currentVelocity = Math.sqrt((movingXNew * movingXNew) + (movingYNew * movingYNew))

    if currentVelocity < player.maxVelocity
      player.movingX = movingXNew
      player.movingY = movingYNew

    player.thrust = true
  else
    player.thrust = false

  if keyPressList[37] == true
    player.rotation -= player.rotationalVelocity

  if keyPressList[39] == true
    player.rotation += player.rotationalVelocity

  if keyPressList[32] == true
    if player.missileFrameCount > player.missileFrameDelay
      firePlayerMissile()
      player.missileFrameCount = 0

update = () ->
  updatePlayer()
  updatePlayerMissiles()
  updateRocks()
  updateSaurcers()
  updateSaurcerMissiles()
  updateParticles()

render = () ->
  fillBackground()
  renderScoreBoard()
  renderPlayerShip(player.x, player.y, player.rotation, 1)
  renderPlayerMissiles()
  renderRocks()
  renderSaucers()
  renderSaucerMissiles()
  renderParticles()

updatePlayer = () ->
  player.missileFrameCount++
  player.x += player.movingX
  player.y += player.movingY

  if player.x > xMax
    player.x -= player.width
  else if player.x < -1 * player.width
    player.x = xMax

  if player.y > yMax
    player.y -= player.height
  else if player.y < -1 * player.height
    player.y = yMax

updatePlayerMissiles = () ->
  tempPlayerMissile = {}
  playerMissileLength = playerMissiles.length-1
  for playerMissileCtr in [0..playerMissileLength].reverse()
    tempPlayerMissile = playerMissiles[playerMissileCtr]
    tempPlayerMissile.x += tempPlayerMissile.dx
    tempPlayerMissile.y += tempPlayerMissile.dy
    if tempPlayerMissile.x > xMax
      tempPlayerMissile.x -= tempPlayerMissile.width
    else if tempPlayerMissile.x < -1 * tempPlayerMissile.width
      tempPlayerMissile.x = xMax

    if tempPlayerMissile.y > yMax
      tempPlayerMissile.y -= tempPlayerMissile.height
    else if tempPlayerMissile.y < -1 * tempPlayerMissile.height
      tempPlayerMissile.y = yMax

    tempPlayerMissile.lifeCtr++
    if tempPlayerMissile.lifeCtr > tempPlayerMissile.life
      playerMissiles.splice(playerMissileCtr,1)
      tempPlayerMissile = null

updateRocks = () ->
  tempRock = {}
  rocksLength = rocks.length - 1
  for rockCtr in [0...rocksLength].reverse()
    tempRock = rocks[rockCtr]
    tempRock.x += tempRock.dx
    tempRock.y += tempRock.dy
    tempRock.rotation += tempRock.rotationInc

    if tempRock.x > x.Max
      tempRock.x = xMin - tempRock.width
    else if tempRock.x < xMin - tempRock.width
      tempRock.x = xMax

    if tempRock.y > y.Max
      tempRock.y = yMin - tempRock.height
    else if tempRock.y < yMin - tempRock.height
      tempRock.y = yMax

updateSaucers = () ->
  if saucers.length < levelSaucerMax
    if Math.floor(Math.random() * 100 < levelSaucerOccurrenceRate
      console.log("create saucer")
      newSaucer = {}

      newSaucer.width = 28
      newSaucer.height = 13
      newSaucer.halfHeight = 6.5
      newSaucer.halfWidth = 14
      newSaucer.scoreValue = saucerScore
      newSaucer.fireRate = levelSaucerFireRate
      newSaucer.fireDelay = levelSaucerFireDelay
      newSaucer.fireDelayCount = 0
      newSaucer.missileSpeed = levelSaucerMissileSpeed
      newSaucer.dy = Math.random() * 2
      newSaucer.dy *= -1 if Math.floor(Math.random() * 2) == 1
      if Math.floor(Math.random()*2) == 1
        newSaucer.x = 450
        newSaucer.dx = -1 * levelSaucerSpeed
      else
        newSaucer.x = -50
        newSaucer.dx = levelSaucerSpeed

      newSaucer.y = Math.floor(Math.random() * 400)
      saucers.push(newSaucer)

  tempSaucer = {}
  saucerLength = saucers.length - 1

  for saucerCtr in [0...saucerLength].reverse()
    tempSaucer = saucers[saucerCtr]
    tempSaucer.fireDelayCount++

    if Math.floor(Math.random() * 100) <= tempSaucer.fireRate and tempSaucer.fireDelayCount > tempSaucer.fireDelay
      fireSaucerMissile(tempSaucer)
      tempSaucer.fireDelayCount = 0

    remove = false
    tempSaucer.x += tempSaucer.dx
    tempSaucer.y += tempSaucer.dy

    if tempSaucer.dx > 0 and tempSaucer.x < xMin - tempSaucer.width
      remove = true
    else if tempSaucer.dx < 0 and tempSaucer.x < xMin - tempSaucer.width
      remove = true

    tempSaucer.dy *= -1 if tempSaucer.y > yMax or tempSaucer.y < yMin - tempSaucer.height

    if remove == true
      console.log("saucer removed")
      saucers.splice(saucerCtr, 1)
      tempSaucer = null

updateSaucerMissiles = () ->
  tempSaucerMissile = {}
  saucerMissileLength = saucerMissiles.length - 1

  for saucerMissileCtr in [0...saucerMissileLength].reverse()
    tempSaucerMissile = saucerMissiles[saucerMissileCtr]
    tempSaucerMissile.x += tempSaucerMissile.dx
    tempSaucerMissile.y += tempSaucerMissile.dy

    if tempSaucerMissile.x > xMax
      tempSaucerMissile.x = -1 * tempSaucerMissile.width
    else if tempSaucerMissile.x < -tempSaucerMissile.width
      tempSaucerMissile.x = xMax

    if tempSaucerMissile.y > yMax
      tempSaucerMissile.y = -tempSaucerMissile.height
    else if tempSaucerMissile.y < -tempSaucerMissile.height
      tempSaucerMissile.y = yMax

    tempSaucerMissile.lifeCtr++
    if tempSaucerMissile.lifeCtr > tempSaucerMissile.life
      saucerMissiles.splice(saucerMissileCtr, 1)
      tempSaucerMissile = null

updateParticles = () ->
  tempParticle = {}
  particleLength = particles.length - 1

  for particleCtr in [0...particleLength].reverse()
    remove = false
    tempParticle = particles[particleCtr]
    tempParticle.x += tempParticle.dx
    tempParticle.y += tempParticle.dy

    tempParticle.lifeCtr++

    if tempParticle.lifeCtr > tempParticle.life
      remove = true
    else if tempParticle.x > xMax or tempParticle.x < xMin or tempParticle.y > yMax or tempParticle.y < yMin
      remove = true

    if remove
      particles.splice(particleCtr, 1)
      tempParticle = null

renderPlayerShip = (x, y, rotation, scale) ->
  angleInRadians = rotation * Math.PI / 180
  context.save()
  context.setTransform(1, 0, 0, 1, 0, 0, 0)

  context.translate(x + player.halfWidth, y + player.halfHeight)
  context.rotate(angleInRadians)
  context.scale(scale, scale)

  context.strokeStyle = "#ffffff"
  context.beginPath()
  context.moveTo(-10,-10)
  context.lineTo(10,0)
  context.moveTo(10,1)
  context.lineTo(-10,10)
  context.lineTo(1,1)
  context.moveTo(-1,1)
  context.lineTo(-10,-10)

  if player.thrust and scale == 1
    context.moveTo(-4,2)
    context.lineTo(-4,1)
    context.moveTo(-5,-1)
    context.lineTo(-10,-1)
    context.moveTo(-5,0)
    context.lineTo(-10,0)

  context.stroke()
  context.closePath()

  context.restore()

renderPlayerMisile = () ->
  tempPlayerMissile = {}
  playerMissileLength = playerMissiles.length - 1

  for playerMissileCtr in [0...playerMissileLength].reverse()
    tempPlayerMissile = playerMissiles[playerMissileCtr]
    context.save()
    context.setTransform(1,0,0,1,0,0)
    context.translate(tempPlayerMissile.x+1,tempPlayerMissile.y+1)
    context.strokeStyle = "#ffffff"

    context.beginPath()

    context.moveTo(-1,-1)
    context.lineTo(1,-1)
    context.lineTo(1,1)
    context.lineTo(-1,1)
    context.lineTo(-1,-1)
    context.stroke()
    context.closePath()
    context.restore()

renderRocks = () ->
  tempRock = {}
  rocksLength = rocks.length - 1

  for rockCtr in [0...rocksLength].reverse()
    tempRock = rocks[rockCtr]
    angleInRadians = tempRock.rotation * Math.PI / 180
    context.save()
    context.setTransform(1,0,0,1,0,0)
    context.translate(tempRock.x + tempRock.halfWidth, tempRock.y + tempRock.halfHeight)
    context.rotate(angleInRadians)
    context.strokeStyle = "#ffffff"

    context.begintPath()

    context.moveTo(-(tempRock.halfWidth - 1),-(tempRock.halfHeight - 1))
    context.lineTo((tempRock.halfWidth - 1),-(tempRock.halfHeight - 1))
    context.lineTo((tempRock.halfWidth - 1),(tempRock.halfHeight - 1))
    context.lineTo((tempRock.halfWidth - 1),(tempRock.halfHeight - 1))
    context.lineTo(-(tempRock.halfWidth - 1),-(tempRock.halfHeight - 1))

    context.stroke()
    context.closePath()
    context.restore()

renderSaucers = () ->
  tempSaucer = {}
  saucerLength = saucers.length - 1

  for saucerCtr in [0...saucerLength].reverse()
    tempSaucer = saucers[saucerCtr]
    context.save()
    context.setTransform(1,0,0,1,0,0)
    context.translate(tempSaucer.x, tempSaucer.y)
    context.strokeStyle = "#ffffff"

    context.begintPath()

    context.moveTo(4,0)
    context.lineTo(9,0)
    context.lineTo(12,3)
    context.lineTo(13,3)
    context.moveTo(13,4)
    context.lineTo(10,7)
    context.lineTo(3,7)
    context.lineTo(1,5)
    context.lineTo(12,5)
    context.moveTo(0,4)
    context.lineTo(0,3)
    context.lineTo(13,3)
    context.moveTo(5,1)
    context.lineTo(5,2)
    context.moveTo(8,1)
    context.lineTo(8,2)
    context.moveTo(2,2)
    context.lineTo(4,0)

    context.stroke()
    context.closePath()
    context.restore()

renderSaucerMissiles = () ->
  tempSaucerMissile = {}
  saucerMissileLength = saucerMissiles.length - 1

  for saucerMissileCtr in [0...saucerMissileLength].reverse()
    tempSaucerMissile = saucerMissiles[saucerMissileCtr]
    context.save()
    context.setTransform(1,0,0,1,0,0)
    context.translate(tempSaucerMissile.x+1, tempSaucerMissile.y+1)
    context.strokeStyle = "#ffffff"

    context.begintPath()

    context.moveTo(-1,-1)
    context.lineTo(1,-1)
    context.lineTo(1,1)
    context.lineTo(-1,1)
    context.lineTo(-1,-1)

    context.stroke()
    context.closePath()
    context.restore()

renderParticles = () ->
  tempParticle = {}
  particleLength = particles.length - 1
  for particleCtr in [0...particleLength].reverse()
    tempParticle = particles[particleCtr]
    context.save()
    context.setTransform(1,0,0,1,0,0)
    context.translate(tempParticle.x, tempParticle.y)
    context.strokeStyle = "#ffffff"

    context.begintPath()

    context.moveTo(0,0)
    context.lineTo(1,1)
    context.stroke()
    context.closePath()
    context.restore()

checkCollisions = () ->
  tempRock = {}
  rocks


###
theCanvas = document.getElementById("canvas")
context = theCanvas.getContext("2d")

gameStatePlayLevel = () ->
  checkKeys()
  update()
  render()

checkKeys = () ->
  if keyPressList[38] == true
    angleInRadians = rotation * Math.PI / 180
    facingX = Math.cos(angleInRadians)
    facingY = Math.sin(angleInRadians)

    movingX = movingX + thrustAcceleration * facingX
    movingY = movingY + thrustAcceleration * facingY

  if keyPressList[37] == true
    rotation -= rotationalVelocity

  if keyPressList[39] == true
    rotation += rotationalVelocity

update = () ->
  x += movingX
  y += movingY

render = () ->
  context.fillStyle = "#000000"
  context.fillRect(0,0,200,200)
  context.fillStyle = "#ffffff"
  context.font = "20px _sans"
  context.textBaseline = "top"
  context.fillText("Player Ship - Static", 0, 180)
  angleInRadians = rotation * Math.PI /180
  context.save()
  context.setTransform(1,0,0,1,0,0)

  context.translate(x+.5*width,y+.5*height)
  context.rotate(angleInRadians)

  context.strokeStyle = "#ffffff"
  context.beginPath()
  context.moveTo(-10,-10)
  context.lineTo(10,0)
  context.moveTo(10,1)
  context.lineTo(-10,10)
  context.lineTo(1,1)
  context.moveTo(1,-1)
  context.lineTo(-10,-10)

  context.stroke()
  context.closePath()

  context.restore()

document.onkeydown = (e) ->
  e = if e then e else window.event
  keyPressList[e.keyCode] = true

document.onkeyup = (e) ->
  e = if e then e else window.event
  keyPressList[e.keyCode] = false

setInterval(gameStatePlayLevel, intervalTime)