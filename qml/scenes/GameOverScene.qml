import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/options_screen-sd.png"
  }

  function backPressed() {
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  function open() {
    opacity = 1
    if(!settingsManager.playerOneDestroyed && settingsManager.playerTwoDestroyed) {
      console.debug("player one has won!")
    } else if(settingsManager.playerOneDestroyed && !settingsManager.playerTwoDestroyed) {
      console.debug("player two has won!")
    } else {
      console.debug("both of you have lost!")
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      // stop fanfare
      audioManager.stopMusic()
      audioManager.playMusic(audioManager.idMusicBG)
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateMainMenuScene()
    }
  }

}
