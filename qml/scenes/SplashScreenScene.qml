import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene
    source: "../img/splash-sd.png"
  }

  Timer {
    id: changeToNextSceneTimer
    interval: 3000
    onTriggered: {
      sceneLoader.activateWarningScene()
    }
  }

  Component.onCompleted: {
    audioManager.playMusic(audioManager.idMusicBG)
    changeToNextSceneTimer.start()
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      changeToNextSceneTimer.stop()
      sceneLoader.activateWarningScene()
    }
  }
}
