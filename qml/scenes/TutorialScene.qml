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

  onBackPressed: {
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

  onEnterPressed: {
    audioManager.play(audioManager.idBUTTON)
    changeToNextScene()
  }
}
