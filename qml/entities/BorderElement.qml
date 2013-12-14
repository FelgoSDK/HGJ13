import VPlay 1.0
import QtQuick 1.1
import "../game"
import ".."

// should collide with every object but not move, therefore dynamic and collisionTestingOnlyMode = true
EntityBase {
  id: border
  entityType: "border"

  // these only exist once and should not be pooled
  preventFromRemovalFromEntityManager: true


  BoxCollider {
    id: collider
    width: parent.width
    height: parent.height
    bodyType: Body.Dynamic


    collisionTestingOnlyMode: true
    categories: settingsManager.borderRegionColliderGroup

    fixedRotation: true

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(collidedEntityType === "rocket") {
        // the obstacle is pooled for better performance
        collidedEntity.removeEntity();
      }
    }
  }
  DebugVisual {
    width: collider.width
    height: collider.height
  }

}
