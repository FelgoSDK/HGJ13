import VPlay 1.0
import QtQuick 1.1
import "../game"
import "../scripts/Vector2d.js" as V

GravityEntity {
  id: shield
  entityType: "shield"
  variationType: "1"
  //anchors.centerIn: parent
  width: collider.width
  height: collider.height

  property int radius: 42
  property int hitpoints: 5
  property real angle: Math.PI / 6

  EditableComponent {
    editableType: "Shield"
    properties: {
      "Shield": {
        "angle":       {"min": 0.05, "max": 0.8, "stepsize": 0.05, "label": "Angle"},
        "radius":      {"min": 20, "max": 100, "label": "Radius"},
        "hitpoints":   {"min": 1, "max": 50, "label": "Hit Points"},
      }
    }
  }

  ShieldPart {
    id: part1
    x: Math.cos(parent.rotation + 2 * angle) * radius - width / 2
    y: Math.sin(parent.rotation + 2 * angle) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part2
    x: Math.cos(parent.rotation + angle) * radius - width / 2
    y: Math.sin(parent.rotation + angle) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part3
    x: Math.cos(parent.rotation) * radius - width / 2
    y: Math.sin(parent.rotation) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part4
    x: Math.cos(parent.rotation - angle) * radius - width / 2
    y: Math.sin(parent.rotation - angle) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part5
    x: Math.cos(parent.rotation - 2 * angle) * radius - width / 2
    y: Math.sin(parent.rotation - 2 * angle) * radius - height / 2
    variationType : parent.variationType
  }

  CircleCollider {
    id: collider
    radius: parent.radius
    friction: 1
    bodyType: Body.Static

    groupIndex: settingsManager.neutralGroup
    categories: settingsManager.shieldColliderGroup
    collidesWith: settingsManager.rocketColliderGroup
    fixedRotation: true
    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;

      --parent.hitpoints;
      if(parent.hitpoints === 4) {
        part5.visible = false
      } else if(parent.hitpoints === 3) {
        part1.visible = false
      } else if(parent.hitpoints === 2) {
        part4.visible = false
      } else if(parent.hitpoints === 1) {
        part2.visible = false
      } else if(parent.hitpoints === 0) {
        part3.visible = false
        destroyShield()
      }
    }
  }

  function destroyShield() {
    collider.active = false
    shield.removeEntity()
  }
}
