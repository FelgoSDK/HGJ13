import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/scores-sd.png"
  }

  function backPressed() {
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  // this allows navigation through key presses
  Keys.onReturnPressed: {
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  property int textSize: 27
  Row {
    id: resultRord
    spacing: 20
    x: 30
    y: 40
    Column {
      id: numberTable
      spacing: 8
      Text {
        text: settingsManager.moon1+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.satellite1+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.city1+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.rocket1+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.comet1+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.shield1+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
    }


    Column {
      spacing: 8
      Text {
        text: "-5"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: "-10"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: "-15"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: "+10"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: "+20"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: "+40"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
    }

    Column {
      spacing: 8
      Text {
        text: settingsManager.moon1*(-5)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.satellite1*(-10)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.city1*(-15)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.rocket1*(+10)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.comet1*(+20)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.shield1*(+40)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
    }
  }

  Text {
    anchors.top: resultRord.bottom
    anchors.topMargin: 30
    anchors.right: resultRord.right

    text: settingsManager.moon1*(-5)+settingsManager.satellite1*(-10)+settingsManager.city1*(-15)+settingsManager.rocket1*(+10)+settingsManager.comet1*(+20)+settingsManager.shield1*(+40)
    
    font.family: fontHUD.name
    color: "white"
    font.pixelSize: scene.textSize+20
  }


  Row {
    id: resultRord2
    spacing: 20
    anchors.right: parent.right
    anchors.rightMargin: 30
    anchors.top: resultRord.top
    Column {
      id: numberTable2
      spacing: 8
      Text {
        text: settingsManager.moon2+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.satellite2+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.city2+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.rocket2+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.comet2+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.shield2+"x"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
    }


    Column {
      spacing: 8
      Text {text: "-5"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: "-10"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: "-15"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: "+10"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: "+20"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: "+40"
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
    }

    Column {
      spacing: 8
      Text {text: settingsManager.moon2*(-5)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.satellite2*(-10)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.city2*(-15)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.rocket2*(+10)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.comet2*(+20)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.shield2*(+40)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
    }
  }

  Text {
    anchors.top: resultRord2.bottom
    anchors.topMargin: 30
    anchors.right: resultRord2.right

    text: settingsManager.moon2*(-5)+settingsManager.satellite2*(-10)+settingsManager.city2*(-15)+settingsManager.rocket2*(+10)+settingsManager.comet2*(+20)+settingsManager.shield2*(+40)
    
    font.family: fontHUD.name
    color: "white"
    font.pixelSize: scene.textSize+20
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      sceneLoader.activateMainMenuScene()
    }
  }

  function open() {
    opacity = 1
    console.debug(settingsManager.balance1, settingsManager.balance2)

    console.debug("moon1", settingsManager.moon1)
    console.debug("moondestroy1", settingsManager.moondestroy1)
    console.debug("satellite1", settingsManager.satellite1)
    console.debug("city1", settingsManager.city1)
    console.debug("rocket1", settingsManager.rocket1)
    console.debug("comet1", settingsManager.comet1)
    console.debug("shield1", settingsManager.shield1)

    console.debug("moon2", settingsManager.moon2)
    console.debug("moondestroy2", settingsManager.moondestroy2)
    console.debug("satellite2", settingsManager.satellite2)
    console.debug("city2", settingsManager.city2)
    console.debug("rocket2", settingsManager.rocket2)
    console.debug("comet2", settingsManager.comet2)
    console.debug("shield2", settingsManager.shield2)
  }
}
