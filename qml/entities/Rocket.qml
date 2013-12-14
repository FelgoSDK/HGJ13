import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: rocket
  entityType: "rocket"
  poolingEnabled: true
  width: sprite.width
  height: sprite.height

  property variant target: undefined
  property int speed: 7
  property real curveFactor: 0.05

  BoxCollider {
    id: collider
    width: sprite.width
    height: sprite.height
    anchors.centerIn: parent
    body.bullet: true
    body.fixedRotation: true
  }

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: "rocket.png"
    translateToCenterAnchor: false
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
      }
    }
  }
}
