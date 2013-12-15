import VPlay 1.0
import QtQuick 1.1
import "../menu"
import ".."

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/about_screen-sd.png"
  }

  function backPressed() {
    sceneLoader.activateMainMenuScene()
  }

  Column {
    id: column
    spacing: 20
    anchors.top: parent.top
    anchors.topMargin: 20
    anchors.right: parent.right
    anchors.rightMargin: 20

    TextButton {
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        settingsManager.sound ^= 1
      }
      textSize: 28
      textColor: "white"
      text: qsTr("David Berger")+translation.language
    }
    TextButton {
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        settingsManager.music ^= 1
      }
      textSize: 28
      textColor: "white"
      text: qsTr("Peter Kainrad")+translation.language
    }
    TextButton {
      id: sleep
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        settingsManager.goToSleep ^= 1
      }
      textSize: 28
      textColor: "white"
      text: qsTr("Fabian Meisinger")+translation.language
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
