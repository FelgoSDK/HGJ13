import QtQuick 1.1
import VPlay 1.0
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene
    source: "../img/splash_screen-sd.png"
  }

  Timer {
    id: changeToNextSceneTimer
    interval: 30000
    onTriggered: {
      sceneLoader.activateIntroScene()
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
      sceneLoader.activateIntroScene()
    }
  }
}
