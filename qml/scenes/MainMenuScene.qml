import QtQuick 1.1
import VPlay 1.0
import "../menu"
import "../"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/splash_screen-sd.png"
  }

  /*Row {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    spacing: 10*/

    TextButton {
      x: 1250/4
      y: 710/4-50
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        sceneLoader.activateLoadingScene()
      }
      font: fontHUD
      text: qsTr("PLAY")+translation.language
    }
    TextButton {
      x: 370/4
      y: 1170/4-50
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        sceneLoader.activateCreditsScene()
      }
      font: fontHUD
      text: qsTr("ABOUT")+translation.language
    }
    TextButton {
      x: 740/4
      y: 930/4-50
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        sceneLoader.activateOptionsScene()
      }
      font: fontHUD
      text: qsTr("OPTIONS")+translation.language
    }
  //}

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
