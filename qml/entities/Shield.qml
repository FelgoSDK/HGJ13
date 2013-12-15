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

  property alias collisionGroup: collider.groupIndex

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
    x: Math.cos(-2 * angle) * radius - width / 2
    y: Math.sin(-2 * angle) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part2
    x: Math.cos(-angle) * radius - width / 2
    y: Math.sin(-angle) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part3
    x: Math.cos(0) * radius - width / 2
    y: Math.sin(0) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part4
    x: Math.cos(angle) * radius - width / 2
    y: Math.sin(angle) * radius - height / 2
    variationType : parent.variationType
  }

  ShieldPart {
    id: part5
    x: Math.cos(2 * angle) * radius - width / 2
    y: Math.sin(2 * angle) * radius - height / 2
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
      hit(-collidedEntity.collisionGroup);
    }
  }

  function hit(playerNumber) {
    if(playerNumber > 0) {
      settingsManager["shield" + playerNumber]++;
      settingsManager["balance" + playerNumber] += settingsManager.shieldScore;
    }

    --shield.hitpoints;
    if(shield.hitpoints === 4) {
      part5.visible = false
    } else if(shield.hitpoints === 3) {
      part1.visible = false
    } else if(shield.hitpoints === 2) {
      part4.visible = false
    } else if(shield.hitpoints === 1) {
      part2.visible = false
    } else if(shield.hitpoints === 0) {
      part3.visible = false
      destroyShield()
    }
  }

  function destroyShield() {
    collider.active = false
    shield.removeEntity()
  }
}
