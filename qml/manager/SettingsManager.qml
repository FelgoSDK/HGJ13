import VPlay 1.0
import QtQuick 1.1

Storage {
  id: storage
  // alias to access storage easily
  property alias storage: storage

  property bool storageLoaded: false

  property bool sound: true
  property bool music: true
  property bool vibrate: true
  property bool goToSleep: false
  property int balance: 0
  property int balance2: 0
  property bool debugVisualsEnabled: false

  property int borderRegionColliderGroup: Box.Category1
  property int pedestrianGroup: Box.Category2
  property int playerColliderGroup: Box.Category3
  property int obstacleColliderGroup: Box.Category4

  onSoundChanged: {
    storage.setValue("sound", sound)
  }

  onMusicChanged: {
    storage.setValue("music", music)
    if(music) {
      audioManager.playMusic(audioManager.idMusicBG)
    } else {
      audioManager.stopMusic()
    }
  }

  onVibrateChanged: {
    storage.setValue("vibrate", vibrate)
  }

  onGoToSleepChanged: {
    storage.setValue("goToSleep", goToSleep)
    nativeUtils.displaySleepEnabled = goToSleep
  }

  onBalanceChanged: {
    storage.setValue("balance", balance)
  }
  onBalance2Changed: {
    storage.setValue("balance2", balance2)
  }


  onDebugVisualsEnabledChanged: {
    storage.setValue("debugVisualsEnabled", debugVisualsEnabled)
  }

  function initFirstStartValues() {
    var firstStartIndicator = storage.getValue("firstStart")

    if(typeof firstStartIndicator === "undefined") {
      // first start of the app
      storage.setValue("firstStart", true)
      firstStartIndicator = true
      storage.setValue("starts", 0)
      storage.setValue("sound", true)
      storage.setValue("music", true)
      storage.setValue("vibrate", true)
      storage.setValue("balance", 0)
      storage.setValue("balance2", 0)
      storage.setValue("gotosleep", false)
      storage.setValue("debugVisualsEnabled", false)
    } else if(firstStartIndicator === true) {
      storage.setValue("firstStart", false)
      firstStartIndicator = false
    }

    var todayDate = Qt.formatDate(new Date(), "yyyy-MM-dd").toString()
    console.debug("stored today:", todayDate, "stored lastStart:", storage.getValue("lastStart"))

    storage.setValue("today", todayDate)
    storage.setValue("lastStart", todayDate)
    storage.setValue("starts", storage.getValue("starts") + 1)

    sound = storage.getValue("sound")
    music = storage.getValue("music")
    vibrate = storage.getValue("vibrate")
    balance = storage.getValue("balance")
    balance2 = storage.getValue("balance2")
    goToSleep = storage.getValue("gotosleep")
    debugVisualsEnabled = storage.getValue("debugVisualsEnabled")
    if(goToSleep) {
      // go to sleep if possible
      nativeUtils.displaySleepEnabled = true;
    }

    // App was started the first time ever, if you need to setup something it can be done here
    if(firstStartIndicator) {

    }
  }

  Component.onCompleted: {
    initFirstStartValues();
    storageLoaded = true
  }
}