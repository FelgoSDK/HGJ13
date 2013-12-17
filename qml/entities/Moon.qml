import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: moon
  entityType: "obstacle"
  poolingEnabled: true
  width: sprite.width
  height: sprite.height

  variationType: "moon"

  property variant target: undefined
  property real speed: 0.005
  property int distance: 150
  property real angle: 0
  property variant origin: Qt.point(0, 0)
  property alias collisionGroup: collider.groupIndex
  property int gravityForce: 1000000
  property int hitpoints: 0

  EditableComponent {
    editableType: "Moon"
    properties: {
      "Obstacle": {
        "speed":               {"min": 0.005, "max": 0.1, "stepsize": 0.005, "label": "Speed"},
        "distance":            {"min": 50, "max": 160, "stepsize": 1, "label": "Distance"},
        "gravityForce":        {"min": 0, "max": 2000000, "stepsize": 100000, "label": "Gravity"},
        "hitpoints":           {"min": 0, "max": 50, "label": "Hitpoints"},
      }
    }
  }

  CircleCollider {
    id: collider
    radius: sprite.width * 0.45
    anchors.centerIn: parent
    bodyType: Body.Kinematic
    groupIndex: settingsManager.neutralGroup
    categories: settingsManager.moonColliderGroup
    collidesWith: settingsManager.cometColliderGroup | settingsManager.rocketColliderGroup

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(collidedEntityType === "rocket") {
        var playerNumber = -collidedEntity.collisionGroup;
        settingsManager["moon" + playerNumber]++
        settingsManager["balance" + playerNumber] += settingsManager.moonScore;
        if(--parent.hitpoints === 0) {
          settingsManager["moondestroy" + playerNumber]++
          settingsManager["balance" + playerNumber] += settingsManager.moonDestroyScore;
          destroyMoon()
        }
      }
    }
  }

  Particle {
    id: flyer
    // particle file
    fileName: "../particles/rocket_explosion.json"

    // start when finished loading
    autoStart: false
    duration: 0.3

    onRunningChanged: {
      if(!running) {
        rmvEntity()
      }
    }
  }

  function destroyMoon() {
    collider.active = false
    sprite.visible = false
    flyer.start()
  }

  function rmvEntity() {
    activeScene.removeEntityFromLogic(moon)
    moon.removeEntity()
  }

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: variationType+".png"
   // translateToCenterAnchor: false
  }

  DebugVisual {
    x: collider.x - collider.radius
    y: collider.y - collider.radius
    width: collider.radius * 2
    height: collider.radius * 2
  }

  Timer {
    interval: 40
    running: true
    repeat: true
    onTriggered: {
      moon.angle += moon.speed
      moon.x = moon.origin.x + Math.cos(moon.angle) * moon.distance
      moon.y = moon.origin.y + Math.sin(moon.angle) * moon.distance
    }
  }
}
