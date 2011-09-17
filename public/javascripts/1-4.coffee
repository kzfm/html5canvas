class Debugger
  log: (message) ->
    try
      console.log(message)
    catch exception
      return

canvasSupport = -> Modernizr.canvas

canvasApp = ->
  return if !canvasSupport()
  guesses = 0
  message = "Guess The Letter From a (lower) to z (heigher)"
  letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
  today = new Date()
  letterToGuess = ""
  higherOrLower = ""
  gameOver = false
  lettersGuessed = []

  theCanvas = document.getElementById("canvasOne")
  context = theCanvas.getContext("2d")

  initGame = ->
    letterIndex = Math.floor(Math.random() * letters.length)
    letterToGuess = letters[letterIndex]
    guesses = 0
    lettersGuessed = []
    gameOver = false
    window.addEventListener("keyup", eventKeyPressed, true)
    formElement = document.getElementById("createImageData")
    formElement.addEventListener("click", createImageDataPressed, false);
    drawScreen()

  eventKeyPressed = (e) ->
    if !gameOver
      letterPressed = String.fromCharCode(e.keyCode)
      letterPressed = letterPressed.toLowerCase()
      guesses++
      lettersGuessed.push(letterPressed)

      if letterPressed == letterToGuess
        gameOver = true
      else
        letterIndex = letters.indexOf(letterToGuess)
        guessIndex = letters.indexOf(letterPressed)
        d.log(guessIndex)
        if guessIndex < 0
          higherOrLower = "That is not a letter"
        else if guessIndex > letterIndex
          higherOrLower = "Lower"
        else
          higherOrLower = "Higher"
      drawScreen()

  drawScreen = ->
    context.fillStyle = "#ffffaa"
    context.fillRect(0, 0, 500, 300)
    # Box
    context.strokeStyle = "#000000"
    context.strokeRect(5, 5, 490, 290)
    context.textBaseline = "top"
    # Date
    context.fillStyle = "#000000"
    context.font = "10px _sans"
    context.fillText(today, 30, 10)
    # Message
    context.fillStyle = "#109910"
    context.font = "16px _sans"
    context.fillText(message, 70, 50)
    # Guesses
    context.fillStyle = "#000000"
    context.font = "10px _sans"
    context.fillText('Guesses: ' + guesses, 420, 10)
    # Higher Or Lower
    context.fillStyle = "#000000"
    context.font = "16px _sans"
    context.fillText('Higher Or Lower: ' + higherOrLower, 150, 125)
    # Letters Guessed
    context.fillStyle = "#FF0000"
    context.font = "16px _sans"
    context.fillText('Letters Guessed: ' + lettersGuessed, 10, 260)
    if gameOver
      context.fillStyle = "#FF0000"
      context.font = "40px _sans"
      context.fillText('You Got It!', 150, 180)

  createImageDataPressed = (e) ->
    window.open(theCanvas.toDataURL(), "canvasImage","left=0,top=0,width=" +
    theCanvas.width + ",height=" + theCanvas.height + ",toolbar=0,resizable=0")

  initGame()

d = new Debugger
canvasApp()