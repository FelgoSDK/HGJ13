import VPlay 1.0
import QtQuick 1.1
import "../game"
import ".."

EntityBase {
  id: border
  entityType: "border"

  BoxCollider {
    id: collider
    width: parent.width
    height: parent.height
    bodyType: Body.Static


    collisionTestingOnlyMode: true
    sensor: true
    categories: settingsManager.borderRegionColliderGroup

    fixedRotation: true

    fixture.onBeginContact: {
      //          var fixture = other;
      //          var body = fixture.parent;
      //          var component = body.parent;
      //          var collidedEntity = component.owningEntity;
      //          var collidedEntityType = collidedEntity.entityType;
      //          if(collidedEntityType === "obstacle") {
      //            hitSound.play()

      //            // the obstacle is pooled for better performance
      //            collidedEntity.removeEntity();

      //            lives--

      //            collision()

      //            if(lives <= 0)
      //              died()
      //          }
    }
  }
  DebugVisual {
    width: parent.width
    height: parent.height
  }

}
