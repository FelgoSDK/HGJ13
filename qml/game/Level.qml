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

  property int borderOffset: 140

  BorderElement {
    x: scene.gameWindowAnchorItem.x-borderOffset
    y: scene.gameWindowAnchorItem.y-20-borderOffset
    width: scene.gameWindowAnchorItem.width+borderOffset+borderOffset
    height: 20
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x-borderOffset
    y: scene.gameWindowAnchorItem.y+scene.gameWindowAnchorItem.height+borderOffset
    width: scene.gameWindowAnchorItem.width+borderOffset+borderOffset
    height: 20
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x-20-borderOffset
    y: scene.gameWindowAnchorItem.y-borderOffset
    width: 20
    height: scene.gameWindowAnchorItem.height+borderOffset+borderOffset
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x+scene.gameWindowAnchorItem.width+borderOffset
    y: scene.gameWindowAnchorItem.y-borderOffset
    width: 20
    height: scene.gameWindowAnchorItem.height+borderOffset+borderOffset
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
    character.weaponPosition = Qt.point(20, 0)
    character.weaponAngle = 0;
    character.minAngle = -45;
    character.maxAngle = 45;

    character2.x = playerDragger2.x = width
    character2.y = playerDragger2.y = centerY
    character2.weaponPosition = Qt.point(-20, 0)
    character2.weaponAngle = 180;
    character2.minAngle = 135;
    character2.maxAngle = 225;

    settingsManager.balance = 0
    settingsManager.balance2 = 0
  }

  function getTarget() {
    return character2;
  }

  function getGravityWells() {
    return [earth];
  }

  function getPlayerControllers() {
    return [character.controller, character2.controller]
  }

  function getPlayer1() {
    return character
  }

  function getPlayer2() {
    return character2
  }

  PlayerDragger {
    id: playerDragger
    onMoveNow: character.moveNow()
    onReleasedNow: character.releasedNow()
  }

  PlayerFollower {
    id: character
    entityId: "p1"
    realTarget: playerDragger
    collisionGroup: settingsManager.player1Group

    inputActionsToKeyCode: {
        "up": Qt.Key_Up,
        "down": Qt.Key_Down,
        "left": Qt.Key_Left,
        "right": Qt.Key_Right
    }
  }

  PlayerDragger {
    id: playerDragger2
    onMoveNow: character2.moveNow()
    onReleasedNow: character2.releasedNow()
  }

  PlayerFollower {
    id: character2
    entityId: "p2"
    realTarget: playerDragger2
    collisionGroup: settingsManager.player2Group

    inputActionsToKeyCode: {
        "up": Qt.Key_W,
        "down": Qt.Key_S,
        "left": Qt.Key_A,
        "right": Qt.Key_D
    }
  }

  Earth {
    id: earth
  }
}
