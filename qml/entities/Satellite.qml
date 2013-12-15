import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: satellite
  entityType: "obstacle"
  poolingEnabled: false
  width: sprite.width
  height: sprite.height
  scale: 0

  variationType: "satellite"

  property variant target: undefined
  property real speed: 0.02
  property int distance: 100
  property real angle: 0
  property variant origin: Qt.point(0, 0)
  property alias collisionGroup: collider.groupIndex
  property int hitpoints: 1
  property int currentDistance: 0
  property int index: 0

 /* EditableComponent {
    editableType: "Satellite"
    properties: {
      "Obstacle": {
        "speed":               {"min": 0.005, "max": 0.1, "stepsize": 0.005, "label": "Speed"},
        "distance":            {"min": 50, "max": 160, "stepsize": 1, "label": "Distance"},
        "hitpoints":           {"min": 0, "max": 50, "label": "Hitpoints"},
      }
    }
  }*/

  BoxCollider {
    id: collider
    width: sprite.width
    height: sprite.height
    anchors.centerIn: parent
    bodyType: Body.Kinematic
    groupIndex: settingsManager.neutralGroup
    categories: settingsManager.satelliteColliderGroup
    collidesWith: settingsManager.rocketColliderGroup

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(--parent.hitpoints === 0) {
        destroySatellite()
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

  function destroySatellite() {
    collider.active = false
    sprite.visible = false
    flyer.start()
  }

  function rmvEntity() {
    scene.removeEntityFromLogic(satellite)
    satellite.removeEntity()
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
      var distance = parent.distance;
      var currentDistance = parent.currentDistance;
      if(currentDistance < parent.distance) {
        currentDistance = parent.currentDistance = Math.min(currentDistance + ~~((distance - currentDistance) / 50) + 1, distance)
        parent.scale = currentDistance / distance
      }

      parent.angle += parent.speed
      parent.x = parent.origin.x + Math.cos(parent.angle) * currentDistance
      parent.y = parent.origin.y + Math.sin(parent.angle) * currentDistance
      parent.rotation = parent.angle * 180 / Math.PI - 90
    }
  }
}
