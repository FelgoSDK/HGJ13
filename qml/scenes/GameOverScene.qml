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

  TextButton {
    id: winnerScreen
    blinkIntervall: 200
    text: qsTr("Winner ...")+translation.language
    anchors.right: scene.right
    anchors.rightMargin: 50
    anchors.top: scene.top
    anchors.topMargin: 130
    font: fontHUD
  }

  TextButton {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    onClicked: {
      // stop ingame music
      //audioManager.stopMusic()
      audioManager.playMusic(audioManager.idMusicBG)
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateMainMenuScene()
    }
    text: qsTr("CONTINUE")+translation.language
  }

  function open() {
    opacity = 1
    if(!settingsManager.playerOneDestroyed && settingsManager.playerTwoDestroyed) {
      winnerScreen.text = qsTr("Player 1 won!")+translation.language
    } else if(settingsManager.playerOneDestroyed && !settingsManager.playerTwoDestroyed) {
      winnerScreen.text = qsTr("Player 2 won!")+translation.language
    } else {
      winnerScreen.text = qsTr("Draw!")+translation.language
    }
  }
}
