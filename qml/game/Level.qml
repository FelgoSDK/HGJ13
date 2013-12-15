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
  property int satelliteCount : 0
  property int cometCount : 0

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
    character.weaponPosition = Qt.point(10,18)
    character.weaponAngle = 0
    character.minAngle = -60
    character.maxAngle = 60
    character.shield = shield1

    character2.weaponPosition = Qt.point(33,34)
    character2.weaponAngle = 0
    character2.minAngle = -60
    character2.maxAngle = 60
    character2.shield = shield2

    moon.origin = Qt.point(level.width/2, level.height/2)
    moon.angle = Math.random() < 0.5 ? -90: 90;

    settingsManager.playerOneDestroyed = 0
    settingsManager.playerTwoDestroyed = 0

    settingsManager.balance1 = 0
    settingsManager.balance2 = 0

    settingsManager.moon1 = 0
    settingsManager.moondestroy1 = 0
    settingsManager.satellite1 = 0
    settingsManager.city1 = 0
    settingsManager.rocket1 = 0
    settingsManager.comet1 = 0
    settingsManager.shield1 = 0

    settingsManager.moon2 = 0
    settingsManager.moondestroy2 = 0
    settingsManager.satellite2 = 0
    settingsManager.city2 = 0
    settingsManager.rocket2 = 0
    settingsManager.comet2 = 0
    settingsManager.shield2 = 0
  }

  function getTarget() {
    return character2;
  }

  function getGravityWells() {
    return [earth, moon];
  }

  function getPlayerControllers() {
    return (character && character2) ? [character.controller, character2.controller] : 0
  }

  Player {
    id: character
    entityId: "1"
    collisionGroup: settingsManager.player1Group

    x: 0
    y: level.height/2-height/2

    inputActionsToKeyCode: {
      "up": Qt.Key_Up,
          "down": Qt.Key_Down,
          "left": Qt.Key_Left,
          "right": Qt.Key_Right
    }
  }

  Shield {
    id: shield1
    anchors.centerIn: character
    collisionGroup: character.collisionGroup
  }

  Player {
    id: character2
    entityId: "2"
    collisionGroup: settingsManager.player2Group
    transformOrigin: Item.Center

    x: level.width-width
    y: level.height/2-height/2
    rotation: 180

    inputActionsToKeyCode: {
      "up": Qt.Key_W,
          "down": Qt.Key_S,
          "left": Qt.Key_A,
          "right": Qt.Key_D
    }
  }

  Shield {
    id: shield2
    rotation: Math.PI
    anchors.centerIn: character2
    collisionGroup: character2.collisionGroup
    variationType: "2"
  }

  Earth {
    id: earth
    onHitByRocket: {
      cityMapReferencGenerator.enterHitNewCity(rocketPlayerID)
    }
  }

  Moon {
    id: moon
  }
  CityMap {
    id: cityMapReferencGenerator
    anchors.top: parent.top
    anchors.topMargin: 10
    anchors.horizontalCenter: parent.horizontalCenter
    property int vertexZ: 5
  }
}
