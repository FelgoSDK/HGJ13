import VPlay 1.0
import QtQuick 1.1

SceneBase {
  id: scene


  SingleSpriteFromFile {

    filename: "../img/images-hd2.json"
    source: "cheese.png"
    translateToCenterAnchor: false
    anchors.centerIn: scene.gameWindowAnchorItem
  }

  /*Video {
    id: video
    anchors.fill: scene.gameWindowAnchorItem
    autoPlay: true
    source: "../videos/intro.mp4"

    onEnded: {
      sceneLoader.activateMainMenuScene()
    }
  }*/

  Timer {
    id: changeToNextSceneTimer
    interval: 30000
    onTriggered: {
      sceneLoader.activateMainMenuScene()
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
      sceneLoader.activateMainMenuScene()
    }
  }
}
