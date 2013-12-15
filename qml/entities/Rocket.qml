import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: rocket
  entityType: "rocket"
  poolingEnabled: true
  width: sprite.width
  height: sprite.height

  variationType: "1"

  property int speed: 7
  property real curveFactor: 0.05
  property alias collisionGroup: collider.groupIndex
  property real oldX: 0
  property real oldY: 0

  EditableComponent {
    editableType: "Rocket"
    properties: {
      "Rocket": {
        "speed":               {"min": 0, "max": 50, "label": "Speed"},
        "curveFactor":           {"min": 0, "max": 1, "stepsize": 0.01, "label": "Curve"},
      }
    }
  }

  BoxCollider {
    id: collider
    width: 3 * sprite.width / 4
    height: sprite.height / 3
    bullet: true
    fixedRotation: true
    groupIndex: settingsManager.neutralGroup
    categories: settingsManager.rocketColliderGroup
    collidesWith: settingsManager.earthColliderGroup | settingsManager.moonColliderGroup | settingsManager.playerColliderGroup | settingsManager.satelliteColliderGroup | settingsManager.cometColliderGroup | settingsManager.shieldColliderGroup | settingsManager.rocketColliderGroup | settingsManager.borderRegionColliderGroup

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;

      if(collidedEntityType === "rocket") {
        var playerNumber = -collidedEntity.collisionGroup;
        if(playerNumber > 0) {
          settingsManager["rocket" + playerNumber]++
          settingsManager["balance" + playerNumber] += settingsManager.rocketScore;
        }
      }

      audioManager.play(audioManager.idEXPOLOSION)
      destroyRocket()
    }
  }

  Particle {
    id: rocketExplosion

    x: sprite.x+sprite.width
    y: sprite.y+sprite.height/2

    // particle file
    fileName: "../particles/rocket_explosion.json"

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

  function destroyRocket() {
    collider.active = false
    sprite.visible = false
    rocketExplosion.start()
  }

  function rmvEntity() {
    scene.removeEntityFromLogic(rocket)
    rocket.removeEntity()
  }

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: "rocket"+variationType+".png"
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
      var position  = getPosition()
      /* if(oldX && oldY) {
        var dx = position.x - oldX;
        var dy = position.y - oldY;
        rocket.rotation = (1 - rocket.curveFactor) * rocket.rotation + rocket.curveFactor * Math.atan2(dy, dx) * 180 / Math.PI;
      }*/

      var angle = rocket.rotation * Math.PI / 180;
      var forward2 = Qt.point(rocket.speed * Math.cos(angle), rocket.speed * Math.sin(angle));
      collider.body.applyLinearImpulse(forward2, position);
      /* oldX = position.x;
      oldY = position.y;*/
    }
  }

  /*  Rectangle {
    anchors.centerIn: collider
    width: 1
    height: 1
    property int vertexZ:10
    color: "blue"
  }

  Rectangle {
    anchors.centerIn: collider
    width: 5
    height: 5
    property int vertexZ:10
    color: "yellow"
  }*/
}
