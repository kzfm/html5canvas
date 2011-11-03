GAME_STATE_TITLE = 0
GAME_STATE_NEW_LEVEL = 1
GAME_STATE_GAME_OVER = 2
FRAME_RATE = 40
intervalTime = 1000 / FRAME_RATE

theCanvas = document.getElementById("canvas")
context = theCanvas.getContext("2d")

currentGameState = 0
currentGameStateFunction = null

switchGameState = (newState) ->
  currentGameState = newState
  switch currentGameState
    when GAME_STATE_TITLE then currentGameStateFunction = gameStateTitle
    when GAME_STATE_NEW_LEVEL then currentGameStateFunction = gameStatePlayLevel
    when GAME_STATE_GAME_OVER then currentGameStateFunction = gameStateGameOver

gameStateTitle = () ->
  console.log("appStateTitle")
  context.fillStyle = "#000000"
  context.fillRect(0,0,200,200)
  context.fillStyle = "#ffffff"
  context.font = "20px _sans"
  context.textBaseline = "top"
  context.fillText("Title Screen", 50, 90)

gameStatePlayLevel = () ->
  console.log("appStateGamePlay")

gameStateGameOver = () ->
  console.log("appStateGameOver")

runGame = () ->
  currentGameStateFunction()

switchGameState(GAME_STATE_TITLE)

setInterval(runGame, intervalTime)