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
    source: "../img/bg_ingame-hd2.png"
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

    playerDragger.x= level.width/2-playerDragger.width/2
    playerDragger.y= 10+50

    character.x= level.width/2-playerDragger.width/2
    character.y= 10+50

    playerDragger2.x= level.width/2-playerDragger.width/2
    playerDragger2.y= level.height-10-50

    character2.x= level.width/2-playerDragger.width/2
    character2.y= level.height-10-50

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
}
