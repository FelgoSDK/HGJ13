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

  Row {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    spacing: 10

    TextButton {
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        sceneLoader.activateLoadingScene()
      }
      text: qsTr("PLAY")+translation.language
    }
    TextButton {
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        sceneLoader.activateCreditsScene()
      }
      text: qsTr("ABOUT")+translation.language
    }
    ImageButton {
      source: "options.png"
      onClicked: {
        audioManager.play(audioManager.idBUTTON)
        sceneLoader.activateOptionsScene()
      }
    }
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
