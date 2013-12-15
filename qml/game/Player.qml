import VPlay 1.0
import QtQuick 1.1
import "../entities"
import "../scripts/Vector2d.js" as V

EntityBase {
  id: followerEntity
  width: sprite.width
  height: sprite.height

  preventFromRemovalFromEntityManager: true

  entityType: "player"
  entityId: "1"
  property variant weaponPosition: Qt.point(0,0)//-tower.width/2, -tower.height/2)
  property real weaponAngle: 0
  property real minAngle: 0
  property real maxAngle: 0
  property real speed: 1
  property bool isShooting: false
  property int attackCooldown: 500
  property bool touchShootEnabled: false

  property bool moveit: false

  property real frameRate: 7

  property int hitpoint: 1

  property alias inputActionsToKeyCode: twoAxisController.inputActionsToKeyCode

  property alias collisionGroup: collider.groupIndex

  property int swayTime: Math.random() * 10

  property variant shield: null

  property int ammo: settingsManager.maxAmmo

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
    translateToCenterAnchor: false

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

      ++swayTime;
      parent.y += Math.cos(swayTime / 50) / 3;
      parent.x += Math.cos(swayTime / 25) / 6;
      parent.rotation += Math.cos(swayTime / 15) / 5;
    }
  }

  Timer {
    id: shootingTimer
    interval: parent.attackCooldown
    running: false
    repeat: true
    onTriggered: {
      if(parent.hitpoint <= 0) {
        shootingTimer.stop()
      } else if(parent.isShooting || touchShootEnabled) {
        releaseTheRockets()
      } else {
        shootingTimer.stop()
        tower.visible = (ammo > 0)
      }
    }
  }

  function releaseTheRockets() {
    if(hitpoint > 0 && ammo > 0) {
      audioManager.play(audioManager.idSHOOT)
      scene.spawnRocket(followerEntity.entityId)
      tower.visible = false

      if(--ammo <= 0 && !reloadTimer.running) {
        reloadTimer.start()
      }
    }
  }

  Timer {
    id: reloadTimer
    interval: settingsManager.reloadTime
    running: false
    repeat: false
    onTriggered: {
      ammo = settingsManager.maxAmmo
      tower.visible = true
    }
  }

  BoxCollider {
    id: collider

    width: sprite.width
    height: sprite.height
    anchors.centerIn: parent
    rotation: parent.rotation

    collisionTestingOnlyMode: true
    bodyType: Body.Kinematic
    groupIndex: settingsManager.neutralGroup
    categories: settingsManager.playerColliderGroup
    collidesWith: settingsManager.rocketColliderGroup

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;

      //apply player damage here
      if(shield && shield.hitpoints > 0) {
        shield.hit(-collidedEntity.collisionGroup);
      } else if(--parent.hitpoint === 0) {
        killPlayer();
      }
    }
  }

  Particle {
    id: killParticleEffect

    //x: sprite.x+sprite.width/2
    //y: sprite.y+sprite.height/2

    // particle file
    fileName: "../particles/player_explosion.json"

    // start when finished loading
    autoStart: false
    //scale: 0.2
    //duration: 0.3

    onRunningChanged: {
      if(!running) {
        rmvEntity()
      }
    }
  }

  function killPlayer() {
    collider.active = false
    sprite.visible = false
    tower.visible = false
    killParticleEffect.start()
  }

  function rmvEntity() {
    scene.startGameEndPhase(entityId);
    followerEntity.removeEntity()
  }

  SingleSpriteFromFile {
    id: tower
    anchors.centerIn: collider

    filename: "../img/images-sd.json"
    source: "rocket"+entityId+".png"
    translateToCenterAnchor: false
    rotation: parent.weaponAngle


  }

  Particle {
    id: laserEffect

    anchors.centerIn: tower
    rotation: tower.rotation

    // particle file
    fileName: "../particles/Laser.json"

    // start when finished loading
    autoStart: true
  }

  DebugVisual {
    x: collider.x
    y: collider.y
    width: collider.width
    height: collider.height
  }


  MultiTouchArea {
    y: scene.gameWindowAnchorItem.y-scene.gameWindowAnchorItem.height/2+parent.height/2
    width: scene.gameWindowAnchorItem.width/2
    height: scene.gameWindowAnchorItem.height

    DebugVisual {
      anchors.fill: parent
      color: "yellow"
    }

    onClicked: {
      changeTurretDir(mouseX,mouseY)
      if(!shootingTimer.running) {
        releaseTheRockets()
        shootingTimer.start()
      }
    }

    onPositionChanged: changeTurretDir(mouseX,mouseY)

    onPressed: {
      changeTurretDir(mouseX,mouseY)
      touchShootEnabled = true
    }
    onReleased: {
      changeTurretDir(mouseX,mouseY)
      touchShootEnabled = false
    }

    function changeTurretDir(mouseX,mouseY){
          var distanceFromXAchsis = mouseY - scene.gameWindowAnchorItem.height/2;
          var angleInDegree = Math.atan2(distanceFromXAchsis, mouseX) / Math.PI * 180
          parent.weaponAngle = (angleInDegree < parent.minAngle) ? parent.minAngle : ((angleInDegree > parent.maxAngle) ? parent.maxAngle : angleInDegree);
          //if(followerEntity.entityId == "2") parent.weaponAngle*=-1
        }
  }


}
