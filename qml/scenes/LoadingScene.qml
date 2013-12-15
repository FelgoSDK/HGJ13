import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  TextButton {
    blinkIntervall: 500
    text: qsTr("Loading ...")+translation.language
    anchors.centerIn: scene.gameWindowAnchorItem
    font: fontHUD
  }

  onOpacityChanged: {
    if(opacity >= 1) {
      sceneLoader.activateGameScene()
    }
  }
}
