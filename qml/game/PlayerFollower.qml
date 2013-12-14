import VPlay 1.0
import QtQuick 1.1
import "../scripts/Vector2d.js" as V

EntityBase {
  id: followerEntity


  preventFromRemovalFromEntityManager: true

  entityType: "player"
  entityId: "1"
  property variant weaponPosition: Qt.point(20, 0)
  property real weaponAngle: 0
  property real minAngle: 0
  property real maxAngle: 0
  property real speed: 1
  property bool isShooting: false
  property int attackCooldown: 500

  property variant realTarget

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
    translateToCenterAnchor: true

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
    /*Sprite {
      name: "run"
      frameNames: [
        entityId+"1.png",
        entityId+"2.png",
        entityId+"1.png",
        entityId+"3.png",
      ]
      frameRate: followerEntity.frameRate
      loop: true
    }*/
  }

  property bool runstarted: false

  onRunstartedChanged: {
    if(runstarted) {
      sprite.jumpTo("run")
      rotationMovement.running = true
    }
  }

  function moveNow() {
    runstarted = true

    if(!finishTimer.running)
      finishTimer.start()
  }

  function releasedNow() {
    if(!finishTimer.running)
      finishTimer.start()
  }

  function calPos() {
    var posFinger = new V.Vector2d(realTarget.x,realTarget.y)
    var posPlayer = new V.Vector2d(followerEntity.x,followerEntity.y)
    var dir = posFinger.subtract(posPlayer)
    dir = dir.normalize()
    followerEntity.frameRate*=dir
    var velocity = 2.7
    dir = dir.multiply(velocity)
    followerEntity.x += dir.x
    followerEntity.y +=dir.y
    if(!finishTimer.running)
      return

    if(Math.abs(followerEntity.x-posFinger.x) < 2 && Math.abs(followerEntity.y - posFinger.y) < 2) {
      finishTimer.stop()
      sprite.jumpTo("idle")
      rotationMovement.running = false
      runstarted = false
    }
  }

  Timer {
    id: finishTimer
    repeat: true
    interval: 16
    onTriggered: {
      //calPos()
    }
  }

  TwoAxisController {
    id: twoAxisController
  }

  // moves the player depending on the twoAxisController
  Timer {
    id: updateTimer
    interval: 20
    running: true
    repeat: true
    onTriggered: {
      var angle = parent.weaponAngle + twoAxisController.xAxis * parent.speed
      parent.weaponAngle = (angle < parent.minAngle) ? parent.minAngle : ((angle > parent.maxAngle) ? parent.maxAngle : angle);
      var isShooting = parent.isShooting = (twoAxisController.yAxis > 0)

      if(isShooting && !shootingTimer.running) {
        scene.spawnRocket(parent.entityId);
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
      if(parent.isShooting) {
        audioManager.play(audioManager.idSHOOT)
        scene.spawnRocket(parent.entityId);
      } else {
        shootingTimer.stop()
      }
    }
  }

  MoveToPointHelper {
    id: moveToPointHelper
    // the entity to move towards
    targetObject: realTarget

    // the following all are optional properties for customization:

    // when the distance to the target gets below this value, the targetReached signal is emitted, default is 20
    distanceToTargetThreshold: 80

    // this allows getting the outputYAxis bigger than 0, which is the default
    allowSteerForward: false

    // if this is set and the target is more than 90 away, allow to move backwards, default is false
    //allowSteerBackward: false


    // if this is set, the follower would only rotate and not move backwards when the target is more than 90 degrees away, default is false
    stopForwardMovementAtDifferentDirections: false
  }

  MovementAnimation {
    id: rotationMovement
    target: followerEntity
    property: "rotation"

    // outputXAxis is +1 if target is to the right, -1 when to the left and 0 when aiming towards it
    velocity: 300*moveToPointHelper.outputXAxis
    // alternatively, also the acceleration could be set, depends on how you want the followerEntity to behave


    // this avoids over-rotating, so rotating further than allowed
    maxPropertyValueDifference: moveToPointHelper.absoluteRotationDifference
  }


  CircleCollider {
    id: collider
    radius: sprite.width/2
    width: sprite.width
    height: sprite.height

    //collisionTestingOnlyMode: true
    //sensor: true
    categories: settingsManager.playerColliderGroup
    groupIndex: settingsManager.neutralGroup

    fixedRotation: true

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;

    }
  }

  DebugVisual {
    x: -sprite.width/2
    y: -sprite.height/2
    width: sprite.width
    height: sprite.height
  }
}
