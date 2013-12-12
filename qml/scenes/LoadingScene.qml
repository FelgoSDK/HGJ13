import VPlay 1.0
import QtQuick 1.1

SceneBase {
  id: scene

  Text {
    text: "Loading..."
    anchors.centerIn: scene.gameWindowAnchorItem
    color: "white"
    font.family: fontHUD.name
  }

  onOpacityChanged: {
    if(opacity >= 1) {
      sceneLoader.activateGameScene()
    }
  }
}
