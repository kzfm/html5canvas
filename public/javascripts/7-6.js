(function() {
  var ALIEN_COLS, ALIEN_ROWS, ALIEN_SPACING, ALIEN_START_X, ALIEN_START_Y, MAX_SOUNDS, SOUND_EXPLODE, SOUND_SHOOT, STATE_INIT, STATE_LOADING, STATE_PLAYING, STATE_RESET, alienImage, aliens, appState, canvasSupport, context, drawScreen, eventMouseMove, eventMouseUp, explodeSound, explodeSound2, explodeSound3, hitTest, initApp, itemLoaded, itemsToLoad, loadCount, missileImage, missiles, playSound, player, playerImage, resetApp, run, shootSound, shootSound2, shootSound3, soundPool, startLevel, supportedAudioFormat, theCanvas;
  canvasSupport = function() {
    return Modernizr.canvas;
  };
  supportedAudioFormat = function(audio) {
    var returnExtention;
    returnExtention = "";
    if (audio.canPlayType("audio/ogg") === "probably" || audio.canPlayType("audio/ogg") === "maybe") {
      returnExtention = "ogg";
    } else if (audio.canPlayType("audio/wav") === "probably" || audio.canPlayType("audio/wav") === "maybe") {
      returnExtention = "wav";
    } else if (audio.canPlayType("audio/mp3") === "probably" || audio.canPlayType("audio/mp3") === "maybe") {
      returnExtention = "mp3";
    }
    return returnExtention;
  };
  STATE_INIT = 10;
  STATE_LOADING = 20;
  STATE_RESET = 30;
  STATE_PLAYING = 40;
  appState = STATE_INIT;
  loadCount = 0;
  itemsToLoad = 0;
  SOUND_EXPLODE = "explode1";
  SOUND_SHOOT = "shoot1";
  MAX_SOUNDS = 6;
  soundPool = new Array();
  player = {
    x: 250,
    y: 475
  };
  aliens = new Array();
  missiles = new Array();
  ALIEN_START_X = 25;
  ALIEN_START_Y = 25;
  ALIEN_ROWS = 3;
  ALIEN_COLS = 10;
  ALIEN_SPACING = 40;
  explodeSound = '';
  explodeSound2 = '';
  explodeSound3 = '';
  shootSound = '';
  shootSound2 = '';
  shootSound3 = '';
  alienImage = new Image();
  missileImage = new Image();
  playerImage = new Image();
  theCanvas = document.getElementById("canvasOne");
  context = theCanvas.getContext("2d");
  itemLoaded = function(event) {
    loadCount++;
    if (loadCount >= itemsToLoad) {
      shootSound.removeEventListener("canplaythrough", itemLoaded, false);
      shootSound2.removeEventListener("canplaythrough", itemLoaded, false);
      shootSound3.removeEventListener("canplaythrough", itemLoaded, false);
      explodeSound.removeEventListener("canplaythrough", itemLoaded, false);
      explodeSound2.removeEventListener("canplaythrough", itemLoaded, false);
      explodeSound3.removeEventListener("canplaythrough", itemLoaded, false);
      soundPool.push({
        name: "explode1",
        element: explodeSound,
        played: false
      });
      soundPool.push({
        name: "explode1",
        element: explodeSound2,
        played: false
      });
      soundPool.push({
        name: "explode1",
        element: explodeSound3,
        played: false
      });
      soundPool.push({
        name: "shoot1",
        element: shootSound,
        played: false
      });
      soundPool.push({
        name: "shoot1",
        element: shootSound2,
        played: false
      });
      soundPool.push({
        name: "shoot1",
        element: shootSound3,
        played: false
      });
      return appState = STATE_RESET;
    }
  };
  initApp = function() {
    loadCount = 0;
    itemsToLoad = 9;
    explodeSound = document.createElement("audio");
    document.body.appendChild(explodeSound);
    explodeSound.setAttribute("src", "/audios/explode1.mp3");
    explodeSound.addEventListener("canplaythrough", itemLoaded, false);
    explodeSound2 = document.createElement("audio");
    document.body.appendChild(explodeSound2);
    explodeSound2.setAttribute("src", "/audios/explode1.mp3");
    explodeSound2.addEventListener("canplaythrough", itemLoaded, false);
    explodeSound3 = document.createElement("audio");
    document.body.appendChild(explodeSound3);
    explodeSound3.setAttribute("src", "/audios/explode1.mp3");
    explodeSound3.addEventListener("canplaythrough", itemLoaded, false);
    shootSound = document.createElement("audio");
    document.body.appendChild(shootSound);
    shootSound.setAttribute("src", "/audios/shoot1.mp3");
    shootSound.addEventListener("canplaythrough", itemLoaded, false);
    shootSound2 = document.createElement("audio");
    document.body.appendChild(shootSound2);
    shootSound2.setAttribute("src", "/audios/shoot1.mp3");
    shootSound2.addEventListener("canplaythrough", itemLoaded, false);
    shootSound3 = document.createElement("audio");
    document.body.appendChild(shootSound3);
    shootSound3.setAttribute("src", "/audios/shoot1.mp3");
    shootSound3.addEventListener("canplaythrough", itemLoaded, false);
    alienImage = new Image();
    alienImage.onload = itemLoaded;
    alienImage.src = "/images/alien.png";
    playerImage = new Image();
    playerImage.onload = itemLoaded;
    playerImage.src = "/images/player.png";
    missileImage = new Image();
    missileImage.onload = itemLoaded;
    missileImage.src = "/images/missile.png";
    return appState = STATE_LOADING;
  };
  startLevel = function() {
    var c, r, _results;
    _results = [];
    for (r = 0; 0 <= ALIEN_ROWS ? r < ALIEN_ROWS : r > ALIEN_ROWS; 0 <= ALIEN_ROWS ? r++ : r--) {
      _results.push((function() {
        var _results2;
        _results2 = [];
        for (c = 0; 0 <= ALIEN_COLS ? c < ALIEN_COLS : c > ALIEN_COLS; 0 <= ALIEN_COLS ? c++ : c--) {
          _results2.push(aliens.push({
            speed: 2,
            x: ALIEN_START_X + c * 40,
            y: ALIEN_START_Y + r * 100,
            width: alienImage.width,
            height: alienImage.height
          }));
        }
        return _results2;
      })());
    }
    return _results;
  };
  resetApp = function() {
    playSound(SOUND_EXPLODE, 0);
    playSound(SOUND_SHOOT, 0);
    startLevel();
    return appState = STATE_PLAYING;
  };
  drawScreen = function() {
    var a, i, j, m, _i, _j, _len, _len2, _len3, _len4, _len5, _len6, _ref, _ref2, _ref3, _ref4;
    _ref = missiles.reverse();
    for (i = 0, _len = _ref.length; i < _len; i++) {
      m = _ref[i];
      m.y -= m.speed;
      if (m.y < 0 - m.height) {
        m.splice(i, 1);
      }
    }
    missiles.reverse();
    _ref2 = aliens.reverse();
    for (i = 0, _len2 = _ref2.length; i < _len2; i++) {
      a = _ref2[i];
      a.x += a.speed;
      if (a.x > (theCanvas.width - a.width) || a.x < 0) {
        a.speed *= -1;
        a.y += 50;
      }
      if (a.y > theCanvas.height) {
        aliens.splice(i, 1);
      }
    }
    aliens.reverse();
    missiles.reverse();
    _ref3 = missiles.reverse();
    for (i = 0, _len3 = _ref3.length; i < _len3; i++) {
      m = _ref3[i];
      _ref4 = aliens.reverse();
      for (j = 0, _len4 = _ref4.length; j < _len4; j++) {
        a = _ref4[j];
        if (hitTest(m, a)) {
          playSound(SOUND_EXPLODE, 0.5);
          missiles.splice(i, 1);
          aliens.splice(j, 1);
        }
      }
      if (aliens.length <= 0) {
        appState = STATE_RESET;
      }
    }
    context.fillStyle = "#ffffff";
    context.fillRect(0, 0, theCanvas.width, theCanvas.height);
    context.strokeStyle = "#eeeeee";
    context.strokeRect(5, 5, theCanvas.width - 10, theCanvas.height - 10);
    context.drawImage(playerImage, player.x, player.y);
    for (_i = 0, _len5 = missiles.length; _i < _len5; _i++) {
      m = missiles[_i];
      context.drawImage(missileImage, m.x, m.y);
    }
    for (_j = 0, _len6 = aliens.length; _j < _len6; _j++) {
      a = aliens[_j];
      context.drawImage(alienImage, a.x, a.y);
    }
    context.fillStyle = "#000000";
    return context.fillText("Active Sounds" + soundPool.length, 200, 480);
  };
  hitTest = function(image1, image2) {
    var r1bottom, r1left, r1right, r1top, r2bottom, r2left, r2right, r2top;
    r1left = image1.x;
    r1top = image1.y;
    r1right = image1.x + image1.width;
    r1bottom = image1.y + image1.height;
    r2left = image2.x;
    r2top = image2.y;
    r2right = image2.x + image2.width;
    r2bottom = image2.y + image2.height;
    return !(r1left > r2right || r1right < r2left || r1bottom < r2top || r1top > r2bottom);
  };
  eventMouseMove = function(event) {
    var mouseX, mouseY;
    if (event.layerX || event.layerX === 0) {
      mouseX = event.layerX;
      mouseY = event.layerY;
    }
    if (event.offsetX || event.offsetX === 0) {
      mouseX = event.offsetX;
      mouseY = event.offsetY;
    }
    player.x = mouseX;
    return player.y = mouseY;
  };
  eventMouseUp = function(event) {
    missiles.push({
      speed: 5,
      x: player.x + 0.5 * playerImage.width,
      y: player.y - missileImage.height,
      width: missileImage.width,
      height: missileImage.height
    });
    return playSound(SOUND_SHOOT, 0.5);
  };
  playSound = function(sound, volume) {
    var soundFound, soundIndex, tSound, tempSound;
    console.log("playsound");
    soundFound = false;
    soundIndex = 0;
    if (soundPool.length > 0) {
      while (!soundFound && soundIndex < soundPool.length) {
        tSound = soundPool[soundIndex];
        if ((tSound.element.ended || !tSound.played) && tSound.name === sound) {
          soundFound = true;
          tSound.played = true;
        } else {
          soundIndex++;
        }
      }
    }
    if (soundFound) {
      tempSound = soundPool[soundIndex].element;
      tempSound.volume = volume;
      return tempSound.play();
    } else if (soundPool.length < MAX_SOUNDS) {
      tempSound = document.createElement("audio");
      tempSound.setAttribute("src", sound + "." + audioType);
      tempSound.volume = volume;
      tempSound.play();
      return soundPool.push({
        name: sound,
        element: tempSound,
        type: audioType,
        played: true
      });
    }
  };
  run = function() {
    switch (appState) {
      case STATE_INIT:
        return initApp();
      case STATE_RESET:
        return resetApp();
      case STATE_PLAYING:
        return drawScreen();
    }
  };
  theCanvas.addEventListener("mouseup", eventMouseUp, false);
  theCanvas.addEventListener("mousemove", eventMouseMove, false);
  setInterval(run, 33);
}).call(this);
