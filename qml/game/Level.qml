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
    character.weaponPosition = Qt.point(20, 0)
    character.weaponAngle = 0;
    character.minAngle = -60;
    character.maxAngle = 60;

    character2.x = playerDragger2.x = width
    character2.y = playerDragger2.y = centerY
    character2.weaponPosition = Qt.point(-20, 0)
    character2.weaponAngle = 180;
    character2.minAngle = 120;
    character2.maxAngle = 240;

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
