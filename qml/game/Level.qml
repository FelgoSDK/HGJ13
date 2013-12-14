import VPlay 1.0
import QtQuick 1.1
import "../entities"
import "../menu"

Item {
  id: level


  Rectangle {
    anchors.fill: parent
    color: "#263357"
  }

  property alias progressRect: progressRect
  Rectangle {
    id:progressRect
    x: 106
    y: 160
    width: 110/maxprogress*progress
    height: 80
  }

  Background {
    id: levelBackground

    anchors.centerIn: level
    source: "../img/bg_ingame-sd.png"
  }

  property int progress: 0
  property int maxprogress: 600
  function updateProgress() {
    progress++
    if(progress >= maxprogress) {
      progress = 0
      scene.stopGame()
    }
  }

  function reset() {
    progressRect.visible = true
    var width = level.width
    var height = level.height
    var centerX = width*0.5
    var centerY = height*0.5
    character.x = playerDragger.x = 0
    character.y = playerDragger.y = centerY

    character2.x = playerDragger2.x = width
    character2.y = playerDragger2.y = centerY

    progress = 0
    settingsManager.balance = 0
    settingsManager.balance2 = 0
  }



  PlayerDragger {
    id: playerDragger
    onMoveNow: character.moveNow()
    onReleasedNow: character.releasedNow()
  }

  PlayerFollower {
    id: character
    entityId: "r"
    realTarget: playerDragger
  }

  PlayerDragger {
    id: playerDragger2
    onMoveNow: character2.moveNow()
    onReleasedNow: character2.releasedNow()
  }

  PlayerFollower {
    id: character2
    entityId: "g"
    realTarget: playerDragger2
  }

  Earth {
    id: earth
  }

  Rocket {
    id: rocket1
    y: earth.y
    x: 30
    target: rocket2
  }

  Rocket {
    id: rocket2
    y: earth.y
    x: 230
    target: rocket1
  }
}
