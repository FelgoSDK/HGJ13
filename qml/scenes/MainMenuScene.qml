import QtQuick 1.1
import VPlay 1.0
import "../menu"
import "../"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/title-sd.png"
  }

  TextButton {
    x: 275/4-384/8
    y: 950/4-192/8
    onClicked: {
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateLoadingScene()
    }
    font: fontHUD
    text: qsTr("play")+translation.language
  }
  TextButton {
    x: 765/4-384/8
    y: 950/4-192/8
    onClicked: {
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateOptionsScene()
    }
    font: fontHUD
    text: qsTr("options")+translation.language
  }
  TextButton {
    x: 1520/4-384/8
    y: 950/4-192/8
    onClicked: {
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateCreditsScene()
    }
    font: fontHUD
    text: qsTr("about")+translation.language
  }

  Connections {
    // nativeUtils should only be connected, when this is the active scene
    target: activeScene === scene ? nativeUtils : null
    onMessageBoxFinished: {
      if(accepted) {
        Qt.quit()
      }
    }
  }

  onBackPressed: {
    audioManager.play(audioManager.idBUTTON)
    nativeUtils.displayMessageBox(qsTr("Really quit the game?")+translation.language, "", 2);
  }

  // this allows navigation through key presses
  Keys.onReturnPressed: {
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateGameScene()
  }
}
