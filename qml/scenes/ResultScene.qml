import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/scores-sd.png"
  }

  onBackPressed: {
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateMainMenuScene()
  }

  onEnterPressed: {
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
      Text {
        text: (settingsManager.playerTwoDestroyed ? 1 : 0) +"x"
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
        text: settingsManager.comet1*(+10)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: settingsManager.shield1*(+20)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {
        text: (settingsManager.playerTwoDestroyed ? 1 : 0)*(+40)
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

    text: settingsManager.moon1*(-5)+settingsManager.satellite1*(-10)+settingsManager.city1*(-15)+settingsManager.comet1*(+10)+settingsManager.shield1*(+20)+(settingsManager.playerTwoDestroyed ? 1 : 0)*(+40)
    
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
      Text {
        text: (settingsManager.playerOneDestroyed ? 1 : 0) +"x"
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
      Text {text: settingsManager.comet2*(+10)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: settingsManager.shield2*(+20)
        font.family: fontHUD.name
        color: "white"
        font.pixelSize: scene.textSize
      }
      Text {text: (settingsManager.playerOneDestroyed ? 1 : 0) *(+40)
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

    text: settingsManager.moon2*(-5)+settingsManager.satellite2*(-10)+settingsManager.city2*(-15)+settingsManager.comet2*(+10)+settingsManager.shield2*(+20)+(settingsManager.playerOneDestroyed ? 1 : 0) *(+40)
    
    font.family: fontHUD.name
    color: "white"
    font.pixelSize: scene.textSize+20
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      audioManager.playMusic(audioManager.idMusicBG)
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateMainMenuScene()
    }
  }
}
