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
