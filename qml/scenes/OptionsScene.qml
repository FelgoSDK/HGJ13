import VPlay 1.0
import QtQuick 1.1
import "../menu"
import "../"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/options_screen-sd.png"
  }

  function backPressed() {
    sceneLoader.activateMainMenuScene()
  }

  Column {
    spacing: 20
    anchors.left: parent.left
    anchors.leftMargin: 20
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width

    TextButton {
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        settingsManager.sound ^= 1
      }
      textSize: 28
      textColor: "black"
      text: settingsManager.sound ? qsTr("Sound...............ON")+translation.language : qsTr("Sound............OFF")+translation.language
    }
    TextButton {
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        settingsManager.music ^= 1
      }
      textSize: 28
      textColor: "black"
      text: settingsManager.music ? qsTr("Music................ON")+translation.language : qsTr("Music.............OFF")+translation.language
    }
    TextButton {
      id: sleep
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        settingsManager.goToSleep ^= 1
      }
      textSize: 28
      textColor: "black"
      text: settingsManager.goToSleep ? qsTr("Sleep Mode....ON")+translation.language : qsTr("Sleep Mode..OFF")+translation.language
    }
    TextButton {
      id: vibrate
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        settingsManager.vibrate ^= 1
      }
      textSize: 28
      textColor: "black"
      text: settingsManager.vibrate ? qsTr("Vibration........ON")+translation.language : qsTr("Vibration......OFF")+translation.language
    }
  }

  TextButton {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    onClicked: {
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateMainMenuScene()
    }
    text: qsTr("BACK")+translation.language
  }
}
