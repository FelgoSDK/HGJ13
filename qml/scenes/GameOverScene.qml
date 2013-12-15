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
    console.debug(settingsManager.balance1, settingsManager.balance2)

    console.debug("moon1", settingsManager.moon1)
    console.debug("moondestroy1", settingsManager.moondestroy1)
    console.debug("satellite1", settingsManager.satellite1)
    console.debug("city1", settingsManager.city1)
    console.debug("rocket1", settingsManager.rocket1)
    console.debug("comet1", settingsManager.comet1)
    console.debug("shield1", settingsManager.shield1)

    console.debug("moon2", settingsManager.moon2)
    console.debug("moondestroy2", settingsManager.moondestroy2)
    console.debug("satellite2", settingsManager.satellite2)
    console.debug("city2", settingsManager.city2)
    console.debug("rocket2", settingsManager.rocket2)
    console.debug("comet2", settingsManager.comet2)
    console.debug("shield2", settingsManager.shield2)

    if(!settingsManager.playerOneDestroyed && settingsManager.playerTwoDestroyed) {
      winnerScreen.text = qsTr("Player 1 won!")+translation.language
    } else if(settingsManager.playerOneDestroyed && !settingsManager.playerTwoDestroyed) {
      winnerScreen.text = qsTr("Player 2 won!")+translation.language
    } else {
      winnerScreen.text = qsTr("Draw!")+translation.language
    }
  }
}
