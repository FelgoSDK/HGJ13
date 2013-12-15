import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: comet
  entityType: "obstacle"
  poolingEnabled: false
  width: sprite.width
  height: sprite.height

  variationType: "comet"

  property variant target: undefined
  property alias collisionGroup: collider.groupIndex
  property int hitpoints: 1

  BoxCollider {
    id: collider
    width: sprite.width
    height: sprite.height
    anchors.centerIn: parent
    bodyType: Body.Dynamic
    groupIndex: settingsManager.neutralGroup
    categories: settingsManager.cometColliderGroup
    collidesWith: settingsManager.earthColliderGroup | settingsManager.moonColliderGroup | settingsManager.rocketColliderGroup | settingsManager.borderRegionColliderGroup
    linearDamping: 0

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(--parent.hitpoints === 0) {
        destroyComet()
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

  function destroyComet() {
    collider.active = false
    sprite.visible = false
    flyer.start()
  }

  function rmvEntity() {
    scene.removeEntityFromLogic(comet)
    comet.removeEntity()
  }

  function applyImpulse(direction) {
    collider.body.applyLinearImpulse(direction, getPosition())
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
     /* var distance = parent.distance;
      var currentDistance = parent.currentDistance;
      if(currentDistance < parent.distance) {
        currentDistance = parent.currentDistance = Math.min(currentDistance + ~~((distance - currentDistance) / 50) + 1, distance)
        parent.scale = currentDistance / distance
      }

      parent.angle += parent.speed
      parent.x = parent.origin.x + Math.cos(parent.angle) * currentDistance
      parent.y = parent.origin.y + Math.sin(parent.angle) * currentDistance
      parent.rotation = parent.angle * 180 / Math.PI - 90*/
    }
  }
}
