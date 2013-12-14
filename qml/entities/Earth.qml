import VPlay 1.0
import QtQuick 1.1
import "../game"
import "../scripts/Vector2d.js" as V

GravityEntity {
  preventFromRemovalFromEntityManager: true

  entityType: "earth"
  anchors.centerIn: parent
  // do not use width/height to avoid problems with collsion/body/image positions!
  //width: sprite.width
  //height: sprite.height

  property int radius: sprite.width*0.45
  property int gravityRadius: radius*4

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: "earth.png"
    //translateToCenterAnchor: false
  }

  DebugVisual {
    x: -sprite.width/2
    y: -sprite.height/2
    width: sprite.width
    height: sprite.height
  }

  CircleCollider {
    id: collider
    radius: parent.radius
    friction: 1
    bodyType: Body.Dynamic

    collisionTestingOnlyMode: true
    sensor: false
    categories: settingsManager.worldColliderGroup
    fixedRotation: true
    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(collidedEntityType === "rocket") {
        collidedEntity.destroyRocket()
      }
    }
  }
}
