import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: rocket
  entityType: "rocket"
  poolingEnabled: true
  width: sprite.width
  height: sprite.height
  // scale: 0.5

  variationType: "1"

  property variant target: undefined
  property int speed: 7
  property real curveFactor: 0.05
  property alias collisionGroup: collider.groupIndex
  property real oldX: 0
  property real oldY: 0

  BoxCollider {
    id: collider
    width: sprite.width
    height: sprite.height
    anchors.centerIn: parent
    body.bullet: true
    body.fixedRotation: true
    groupIndex: settingsManager.neutralGroup

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(collidedEntityType === "rocket") {
        destroyRocket()
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

  function destroyRocket() {
    collider.active = false
    sprite.visible = false
    flyer.start()
  }

  function rmvEntity() {
    scene.removeEntityFromLogic(rocket)
    rocket.removeEntity()
  }

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: "rocket"+variationType+".png"
    //translateToCenterAnchor: false
  }

  DebugVisual {
    x: -sprite.width/2
    y: -sprite.height/2
    width: sprite.width
    height: sprite.height
  }

  Timer {
    interval: 40
    running: true
    repeat: true
    onTriggered: {
      if(target) {
        var oldHeading = rocket.rotation * Math.PI / 180;

        var atanY = target.y + (target.height / 2) - rocket.y;
        var atanX = target.x + (target.width / 2) - rocket.x;

        var TheAngle = Math.atan2(atanY, atanX);
        if(Math.abs(TheAngle-oldHeading) > Math.PI) {
          var sign = TheAngle?TheAngle<0?-1:1:0
          TheAngle = TheAngle - sign*Math.PI*2;
        }

        var heading = (1 - rocket.curveFactor) * oldHeading + rocket.curveFactor * TheAngle;

        rocket.rotation = heading * 180 / Math.PI
        var forward = Qt.point(rocket.speed * Math.cos(heading), rocket.speed * Math.sin(heading));
        collider.body.applyLinearImpulse(forward,getPosition());
      } else {
        var position  = getPosition()
        if(oldX && oldY) {
          var dx = position.x - oldX;
          var dy = position.y - oldY;
          rocket.rotation = (1 - rocket.curveFactor) * rocket.rotation + rocket.curveFactor * Math.atan2(dy, dx) * 180 / Math.PI;
        }

        var angle = rocket.rotation * Math.PI / 180;
        var forward2 = Qt.point(rocket.speed * Math.cos(angle), rocket.speed * Math.sin(angle));
        collider.body.applyLinearImpulse(forward2, position);
        oldX = position.x;
        oldY = position.y;
      }
    }
  }
}
