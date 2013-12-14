import VPlay 1.0
import QtQuick 1.1
import "../scripts/levelLogic.js" as LevelLogic
import "../game"

SceneBase {
  id: scene

  controllerOfScene: level.getPlayerControllers()
  property alias itemEditor: itemEditor
  // debug scale to see whole scene and colliders
  //scale: 0.5

  // allows collision detection with pyhsics colliders (BoxColliders, CircleColliders and PolygonColliders)
  // it supports 2 modes:
  //  - for collision testing (set collisionTestingOnlyMode to true) when the positions get updated manually, e.g. by animations
  //  - for physics driven games like AngryBirds or this sample game
  PhysicsWorld {
    id: physicsWorld
    // this puts it on top of all other items for the physics debug renderer
    z: 1

    // for physics-based games, this should be set to 60!
    updatesPerSecondForPhysics: 60

    // this should be increased so it looks good, by default it is set to 1 to save performance
    // when it is left at 1, the ball sometimes "float" into the wall or paddles
    velocityIterations: 5
    positionIterations: 5
    debugDrawVisible: true
  }

  EntityManager {
    id: entityManager
    // forward container allways to container of scene
    entityContainer: entityContainerOfScene
    // forward dynamic entity list e.g. used for level editor
    //dynamicCreationEntityList: activeScene.dynamicCreationEntityList
  }

  entityContainerOfScene: level

  Level {
    id: level
    anchors.centerIn: scene.gameWindowAnchorItem
    width: parent.width
    height: parent.height
  }

  Text {
    id: debugTextForRockets
    color: "white"
    visible: developerBuild
  }

  Button  {
    anchors.right: scene.gameWindowAnchorItem.right
    anchors.top: scene.gameWindowAnchorItem.top
    text: qsTr("Menu")+translation.language
    onClicked: {
      settingsManager.debugVisualsEnabled^=1
    }
    visible: developerBuild
  }
  ItemEditor {
    id: itemEditor
    width: parent.width/4
    height: parent.height
    opacity: 0.4
    visible: settingsManager.debugVisualsEnabled && developerBuild
  }

  property bool gameIsRunning: false

  function initScene() {
    LevelLogic.init()
  }

  onOpacityChanged: {
    if(opacity >= 1) {
      startGame()
    }
  }

  function open() {
    opacity = 1
    audioManager.stopMusic()
    audioManager.playMusic()
  }

  function close() {
    opacity = 0
    audioManager.stopMusic()
    stopGame()
    entityManager.removeAllEntities()
  }

  function backPressed() {
    if(developerBuild)
      stopGame()
  }

  function startGame() {
    gameIsRunning = true
    level.reset()
    gameTime.start()
    LevelLogic.setGravityWells(level.getGravityWells())
    LevelLogic.setPlayers(level.getPlayer1(), level.getPlayer2())
  }

  function stopGame() {
    if(!gameIsRunning)
      return

    gameIsRunning = false
    gameTime.stop()
    sceneLoader.activateGameOverScene()
  }

  function spawnRocket(playerId) {
    LevelLogic.spawnRocket(playerId)
  }

  function removeEntityFromLogic(entity) {
    LevelLogic.removeObject(entity.id)
  }

  Timer {
    id: gameTime
    interval: 50
    repeat: true
    onTriggered: {
      level.update()
      LevelLogic.applyGravity()

      if(debugTextForRockets.visible) {
        debugTextForRockets.text = LevelLogic.objectsCount
      }

    }

  }
}
