import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  TextButton {
    id: warnung
    anchors.top: parent.top
    anchors.topMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter
    font: fontHUD
    text: qsTr("Epilepsie Warnung")+translation.language
    blinkIntervall: 100
  }

  Text {
    id: first
    anchors.top: warnung.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    text: qsTr("WARNUNG: VOR DEM SPIELEN LESEN!\nBei manchen Personen kann es in besonderen Fällen zu epileptischen Anfällen oder Bewusstseinsstörungen kommen, wenn sie bestimmten Blitzlichtern oder Lichteffekten ausgesetzt sind.Diese Personen können möglicherweise bei der Benutzung von Computer- und Videospielen einen Anfall erleiden. Hiervon können auch Personen betroffen sein, deren Krankheitsgeschichte bislang keine Epilepsie aufweist und die nie zuvor epileptische Anfälle gehabt haben [...]")+translation.language
    color: "White"
    width: parent.width-30
    height: 200
  }


  Timer {
    id: changeToNextSceneTimer
    interval: 20000
    onTriggered: {
      sceneLoader.activateIntroScene()
    }
  }

  Component.onCompleted: {
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
