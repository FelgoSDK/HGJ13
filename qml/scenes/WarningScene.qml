import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  TextButton {
    id: warnung
    anchors.top: scene.gameWindowAnchorItem.top
    anchors.topMargin: 20
    anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
    font: fontHUD
    text: qsTr("EPILEPSY WARNING")+translation.language
    blinkIntervall: 100
  }

  Text {
    id: first
    anchors.top: warnung.bottom
    anchors.left: scene.gameWindowAnchorItem.left
    anchors.leftMargin: 20
    text: qsTr("READ THIS NOTICE BEFORE YOU OR YOUR CHILD USE ANY VIDEO GAME\nA very small portion of the population have a condition which may cause them to experience epileptic seizures or have momentary loss of consciousness when viewing certain kinds of flashing lights or patterns that are commonly present in our daily environment. These persons may experience seizures while watching some kinds of television pictures or playing certain video games. Players who have not had any previous seizures may nonetheless have an undetected epileptic condition.")+translation.language
    color: "White"
    width: scene.width-40
    height: 250
  }

  Timer {
    id: changeToNextSceneTimer
    interval: 10000
    onTriggered: {
      sceneLoader.activateIntroScene()
    }
  }

  Component.onCompleted: {
    changeToNextSceneTimer.start()
  }

  onEnterPressed: {
    changeToNextSceneTimer.stop()
    sceneLoader.activateIntroScene()
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      changeToNextSceneTimer.stop()
      sceneLoader.activateIntroScene()
    }
  }
}
