import VPlay 1.0
import QtQuick 1.1

SceneBase {
  id: scene

  MultiResolutionImage {
    id: redWins
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/end_of_game_red-hd2.png"
  }

  MultiResolutionImage {
    id: greenWins
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/end_of_game_green-hd2.png"
  }

  MultiResolutionImage {
    id: drawWins
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/end_of_game_draw-hd2.png"
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

    audioManager.playMusic(audioManager.idMusicFanfare)

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
