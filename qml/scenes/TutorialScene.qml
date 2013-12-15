import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/bg_ingame-sd.png"
  }

  MultiResolutionImage {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: system.desktopPlatform  ? "../img/tutorial_desktop-sd.png" : "../img/tutorial_mobile-sd.png"
  }

  function backPressed() {
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      audioManager.play(audioManager.idBUTTON)
      changeToNextScene()
    }
  }

  function changeToNextScene() {
    if(settingsManager.cameFromHelpMenu) {
      sceneLoader.activateOptionsScene()
    } else {
      sceneLoader.activateLoadingScene()
    }
  }

  // this allows navigation through key presses
  Keys.onReturnPressed: {
    audioManager.play(audioManager.idBUTTON)
    changeToNextScene()
  }
}
