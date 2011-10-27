canvasSupport = -> Modernizr.canvas

canvasApp = ->
  return if not canvasSupport
  videoElement.play()

console.log("ok")

drawScreen = ->
  context.fillStyle = "#303030"
  context.fillRect(0, 0, theCanvas.width, theCanvas.height)

  context.strokeStyle = "#ffffff"
  context.strokeRect(5, 5, theCanvas.width-10, theCanvas.height-10)

  for c in [0...cols]
    for r in [0...rows]
      tempPiece = board[c][r]
      imageX = tempPiece.finalCol * partWidth
      imageY = tempPiece.finalRow * partHeight
      placeX = c * partWidth + c * xPad + startXOffset
      placeY = r * partHeight + r * yPad + startYOffset
      context.drawImage(videoElement, imageX, imageY, partWidth, partHeight, placeX, placeY, partWidth, partHeight)

      if tempPiece.selected
        context.strokeStyle = '#ffff00'
        context.strokeRect(placeX, placeY, partWidth, partHeight)

randomizeBoard = (board) ->
  console.log("randomize start")
  newBoard = new Array()
  cols = board.length
  rows = board[0].length
  for i in [0...cols]
    newBoard[i] = new Array()
    for j in [0...rows]
      found = false
      rndCol = 0
      rndRow = 0
      while !found
        rndCol = Math.floor(Math.random() * cols)
        rndRow = Math.floor(Math.random() * rows)
        found = true if board[rndCol][rndRow] != false

      newBoard[i][j] = board[rndCol][rndRow]
      board[rndCol][rndRow] = false
  console.log("randomize finish")
  newBoard

eventMouseUp = (event) ->
  if event.layerX or event.layout == 0
    mouseX = event.layerX
    mouseY = event.layerY
  else if event.offsetX or event.offsetX == 0
    mouseX = event.offsetX
    mouseY = event.offsetY

  console.log("x:" + mouseX + " y:" + mouseY)

  selectedList = new Array()
  for c in [0...cols]
    for r in [0...rows]
      pieceX = c * partWidth + c * xPad + startXOffset
      pieceY = r * partHeight + r * yPad + startYOffset

      if mouseY >= pieceY and mouseY <= pieceY + partHeight and mouseX >= pieceX and mouseX <= pieceX + partWidth
        board[c][r].selected = if board[c][r].selected then false else true

      selectedList.push({col:c,row:r}) if board[c][r].selected

  if selectedList.length == 2
    selected1 = selectedList[0]
    selected2 = selectedList[1]
    tempPiece1 = board[selected1.col][selected1.row]
    board[selected1.col][selected1.row] = board[selected2.col][selected2.row]
    board[selected2.col][selected2.row] = tempPiece1
    board[selected2.col][selected2.row].selected = false
    board[selected1.col][selected1.row].selected = false

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

videoElement.setAttribute("src","/videos/sample." + videoType)
videoElement.addEventListener("canplaythrough", videoLoaded, false)

theCanvas = document.getElementById("canvasOne")
context = theCanvas.getContext("2d")

rows = 4
cols = 4
xPad = 10
yPad = 10
startXOffset = 10
startYOffset = 10
partWidth = 80
partHeight = 60
board = new Array()

console.log("init value ok")

for i in [0...cols]
  board[i] = new Array()
  for j in [0...rows]
    board[i][j] = {finalCol:i,finalRow:j,selected:false}

board = randomizeBoard(board)
theCanvas.addEventListener("mouseup",eventMouseUp,false)

setInterval(drawScreen, 33)