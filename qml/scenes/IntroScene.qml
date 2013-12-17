import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene
    source: "../img/logo-sd.png"
  }

  Timer {
    id: changeToNextSceneTimer
    interval: 3000
    onTriggered: {
      sceneLoader.activateMainMenuScene()
    }
  }

  Component.onCompleted: {
    changeToNextSceneTimer.start()
  }

  onEnterPressed: {
    changeToNextSceneTimer.stop()
    sceneLoader.activateMainMenuScene()
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      changeToNextSceneTimer.stop()
      sceneLoader.activateMainMenuScene()
    }
  }
}
