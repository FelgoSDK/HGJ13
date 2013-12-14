import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: obstacle
  entityType: "obstacle"
  poolingEnabled: true
  width: sprite.width
  height: sprite.height

  variationType: "satellite"

  property variant target: undefined
  property real speed: 0.1
  property int distance: 100
  property real angle: 0
  property variant origin: Qt.point(0, 0)
  property alias collisionGroup: collider.groupIndex
  property int obstacleType: 0

  onObstacleTypeChanged: {
    switch(obstacleType) {
      case 2: variationType = "moon"; break;
      case 1: variationType = "comet"; break;
      case 0:
      default: variationType = "satellite"; break;
    }
  }

  EditableComponent {
    editableType: "Game Settings"
    properties: {
      "Obstacle": {
        "speed":               {"min": 0.005, "max": 0.1, "stepsize": 0.005, "label": "Speed"},
        "distance":            {"min": 40, "max": 160, "stepsize": 1, "label": "Distance"},
        "obstacleType":        {"min": 0, "max": 2, "stepsize": 1, "label": "Obstacle Type"},
      }
    }
  }

  BoxCollider {
    id: collider
    width: sprite.width
    height: sprite.height
    anchors.centerIn: parent
    bodyType: Body.Kinematic
    groupIndex: settingsManager.neutralGroup
    colliderType: settingsManager.obstacleColliderGroup

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(collidedEntityType === "rocket") {
        destroyObstacle()
      }
    }
  }

  Particle {
    id: flyer

    //x: sprite.x+sprite.width/2
    //y: sprite.y+sprite.height/2

    // particle file
    fileName: "../particles/BoingStar.json"

    // start when finished loading
    autoStart: false
    //scale: 0.2
    duration: 0.3

    onRunningChanged: {
      if(!running) {
        rmvEntity()
      }
    }
  }

  function destroyObstacle() {
    collider.active = false
    sprite.visible = false
    flyer.start()
  }

  function rmvEntity() {
    scene.removeEntityFromLogic(obstacle)
    obstacle.removeEntity()
  }

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: variationType+".png"
    translateToCenterAnchor: false
  }

  DebugVisual {
    x: collider.x
    y: collider.y
    width: collider.width
    height: collider.height
  }

  Timer {
    interval: 40
    running: true
    repeat: true
    onTriggered: {
      obstacle.angle += obstacle.speed
      obstacle.x = obstacle.origin.x + Math.cos(obstacle.angle) * obstacle.distance
      obstacle.y = obstacle.origin.y + Math.sin(obstacle.angle) * obstacle.distance
    }
  }
}
