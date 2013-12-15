import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/bg_ingame-sd.png"
  }

  function backPressed() {
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  Column {
    TextButton {
      blinkIntervall: 200
      text: qsTr("Moon1 ...")+translation.language+settingsManager.moon1
      font: fontHUD
      textSize: 25
    }
    TextButton {
      blinkIntervall: 200
      text: qsTr("moondestroy1 ...")+translation.language+settingsManager.moondestroy1
      font: fontHUD
      textSize: 25
    }
  }

  TextButton {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    onClicked: {
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
  }
}
