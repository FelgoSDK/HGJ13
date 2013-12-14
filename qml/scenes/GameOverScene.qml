import VPlay 1.0
import QtQuick 1.1

SceneBase {
  id: scene

  MultiResolutionImage {
    id: redWins
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/end_of_game_red-sd.png"
  }

  MultiResolutionImage {
    id: greenWins
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/end_of_game_green-sd.png"
  }

  MultiResolutionImage {
    id: drawWins
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/end_of_game_draw-sd.png"
  }

  function backPressed() {
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  function open() {
    drawWins.visible = false
    redWins.visible = false
    greenWins.visible = false

    opacity = 1
    if(settingsManager.balance === settingsManager.balance2) {
      drawWins.visible = true
    } else {
      if(settingsManager.balance > settingsManager.balance2) {
        redWins.visible = true
      } else {
        greenWins.visible = true
      }
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
