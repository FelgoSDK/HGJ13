import VPlay 1.0
import QtQuick 1.1
import "../scripts/Vector2d.js" as V

EntityBase {
  preventFromRemovalFromEntityManager: true

  entityType: "earth"
  anchors.centerIn: parent
  width: sprite.width
  height: sprite.height

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: "earth.png"
    translateToCenterAnchor: false
  }

  /*  CircleCollider {
    id: collider
    radius: sprite.width/2
    width: sprite.width
    height: sprite.height

    collisionTestingOnlyMode: true
    sensor: false
    categories: settingsManager.playerColliderGroup

    fixedRotation: true

    fixture.onBeginContact: {
     // var fixture = other;
    //  var body = fixture.parent;
     // var component = body.parent;
    //  var collidedEntity = component.owningEntity;
    //  var collidedEntityType = collidedEntity.entityType;
     // if(collidedEntityType === "pedestrian") {
        //audioManager.play(audioManager.idNEVER)
     // }
    }
  }

  DebugVisual {
    x: -sprite.width/2
    y: -sprite.height/2
    width: sprite.width
    height: sprite.height
  }*/
}
