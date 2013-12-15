import VPlay 1.0
import QtQuick 1.1
import "../scripts/Vector2d.js" as V

EntityBase {
  id: followerEntity


  //preventFromRemovalFromEntityManager: true

  entityType: "player"
  entityId: "1"
  property variant weaponPosition: Qt.point(20, 0)
  property real weaponAngle: 0
  property real minAngle: 0
  property real maxAngle: 0
  property real speed: 1
  property bool isShooting: false
  property int attackCooldown: 500
  property bool touchShootEnabled: false

  property bool moveit: false

  property real frameRate: 7

  property alias inputActionsToKeyCode: twoAxisController.inputActionsToKeyCode

  property alias collisionGroup: collider.groupIndex

  // gets accessed to insert the input when touching the HUDController
  property alias controller: twoAxisController

  EditableComponent {
    editableType: "Player"
    properties: {
      "Player": {
        //"weaponAngle":               {"min": 0, "max": 50, "label": "Speed"},
        //"minAngle":           {"min": 0, "max": 1, "stepsize": 0.01, "label": "Curve"},
        //"maxAngle":           {"min": 0, "max": 1, "stepsize": 0.01, "label": "Curve"},
        "speed":           {"min": 0, "max": 100, "label": "Speed"},
        "attackCooldown":           {"min": 100, "max": 2000, "stepsize": 100, "label": "Cooldown"},
      }
    }
  }

  SpriteSequenceFromFile {
    id: sprite
    //translateToCenterAnchor: true

    filename: "../img/images-sd.json"
    running: true

    Sprite {
      name: "idle"
      frameNames: [
        entityType+entityId+".png",
      ]
      frameRate: followerEntity.frameRate

      loop: true
    }
  }

  TwoAxisController {
    id: twoAxisController
  }

  // moves the player depending on the twoAxisController
  Timer {
    id: updateTimer
    interval: 80
    running: true
    repeat: true
    onTriggered: {
      var angle = parent.weaponAngle + twoAxisController.xAxis * parent.speed
      parent.weaponAngle = (angle < parent.minAngle) ? parent.minAngle : ((angle > parent.maxAngle) ? parent.maxAngle : angle);
      var isShooting = parent.isShooting = (twoAxisController.yAxis > 0)

      if((isShooting || touchShootEnabled) && !shootingTimer.running ) {
        releaseTheRockets()
        shootingTimer.start()
      }
    }
  }

  Timer {
    id: shootingTimer
    interval: parent.attackCooldown
    running: false
    repeat: true
    onTriggered: {
      if(parent.isShooting || touchShootEnabled) {
        releaseTheRockets()
      } else {
        shootingTimer.stop()
      }
    }
  }

  function releaseTheRockets() {
    audioManager.play(audioManager.idSHOOT)
    scene.spawnRocket(followerEntity.entityId)
  }

  CircleCollider {
    id: collider
    radius: sprite.width/2
    width: sprite.width
    height: sprite.height

    collisionTestingOnlyMode: true
    bodyType: Body.Kinematic
    groupIndex: settingsManager.neutralGroup
    categories: settingsManager.playerColliderGroup
    collidesWith: settingsManager.rocketColliderGroup

    fixedRotation: true

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;

      //apply player damage here
    }
  }

  SingleSpriteFromFile {
    id: tower
    filename: "../img/images-sd.json"
    source: "rocket"+entityId+".png"
    //translateToCenterAnchor: false
    rotation: parent.weaponAngle
  }


  DebugVisual {
    x: -sprite.width/2
    y: -sprite.height/2
    width: sprite.width
    height: sprite.height
  }


  MultiTouchArea {
    x: scene.gameWindowAnchorItem.x
    y: scene.gameWindowAnchorItem.y-scene.gameWindowAnchorItem.height/2
    width: scene.gameWindowAnchorItem.width/2
    height: scene.gameWindowAnchorItem.height

    DebugVisual {
      x: parent.x
      y: parent.y
      width: parent.width
      height: parent.height
      color: "yellow"
    }

    onClicked: {
      var distanceFromXAchsis = mouseY - scene.gameWindowAnchorItem.height/2;
      var angleInDegree = Math.atan2(distanceFromXAchsis, mouseX) / Math.PI * 180
      parent.weaponAngle = (angleInDegree < parent.minAngle) ? parent.minAngle : ((angleInDegree > parent.maxAngle) ? parent.maxAngle : angleInDegree);
    }

    onPressed: {
      var distanceFromXAchsis = mouseY - scene.gameWindowAnchorItem.height/2;
      var angleInDegree = Math.atan2(distanceFromXAchsis, mouseX) / Math.PI * 180
      parent.weaponAngle = (angleInDegree < parent.minAngle) ? parent.minAngle : ((angleInDegree > parent.maxAngle) ? parent.maxAngle : angleInDegree);

    }

    onReleased: {
      var distanceFromXAchsis = mouseY - scene.gameWindowAnchorItem.height/2;
      var angleInDegree = Math.atan2(distanceFromXAchsis, mouseX) / Math.PI * 180
      parent.weaponAngle = (angleInDegree < parent.minAngle) ? parent.minAngle : ((angleInDegree > parent.maxAngle) ? parent.maxAngle : angleInDegree);

    }
  }

  MultiTouchArea {
    anchors.centerIn: parent
    width: 80
    height: 80

    DebugVisual {
      x: parent.x
      y: parent.y
      width: parent.width
      height: parent.height
      color: "green"
    }

    onClicked: {
      if(!shootingTimer.running) {
        releaseTheRockets()
        shootingTimer.start()
      }
    }
    onPressed: {
      touchShootEnabled = true
    }

    onReleased: {
      touchShootEnabled = false
    }
  }
}
