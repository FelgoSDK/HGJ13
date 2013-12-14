import VPlay 1.0
import QtQuick 1.1
import "../entities"
import "../menu"

Item {
  id: level

  Background {
    id: levelBackground

    anchors.centerIn: level
    source: "../img/bg_ingame-sd.png"
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x
    y: scene.gameWindowAnchorItem.y-20
    width: scene.gameWindowAnchorItem.width
    height: 20
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x
    y: scene.gameWindowAnchorItem.y+scene.gameWindowAnchorItem.height
    width: scene.gameWindowAnchorItem.width
    height: 20
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x-20
    y: scene.gameWindowAnchorItem.y
    width: 20
    height: scene.gameWindowAnchorItem.height
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x+scene.gameWindowAnchorItem.width
    y: scene.gameWindowAnchorItem.y
    width: 20
    height: scene.gameWindowAnchorItem.height
  }

  function update() {
  }

  function reset() {
    var width = level.width
    var height = level.height
    var centerX = width*0.5
    var centerY = height*0.5
    character.x = playerDragger.x = 0
    character.y = playerDragger.y = centerY

    character2.x = playerDragger2.x = width
    character2.y = playerDragger2.y = centerY

    settingsManager.balance = 0
    settingsManager.balance2 = 0
  }

  function getTarget() {
    return character2;
  }

  function getGravityWells() {
    return [earth];
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
}
