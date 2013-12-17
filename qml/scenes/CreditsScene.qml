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

  onBackPressed:  {
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  onEnterPressed: {
    audioManager.play(audioManager.idBUTTON)
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
      textSize: 28
      textColor: "white"
      text: qsTr("David Berger")+translation.language
    }
    TextButton {
      textSize: 28
      textColor: "white"
      text: qsTr("Peter Kainrad")+translation.language
    }
    TextButton {
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
