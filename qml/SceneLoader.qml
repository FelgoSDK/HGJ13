import QtQuick 1.1
import VPlay 1.0
import "scenes"

Item {
  property string splashScene: "scenes/SplashScreenScene.qml"
  property string warningScene: "scenes/WarningScene.qml"
  property string introScene: "scenes/IntroScene.qml"
  property string mainMenuScene: "scenes/MainMenuScene.qml"
  property string creditsScene: "scenes/CreditsScene.qml"
  property string optionScene: "scenes/OptionsScene.qml"
  property string gameScene: "scenes/GameScene.qml"
  property string gameOverScene: "scenes/GameOverScene.qml"
  property string loadingScene: "scenes/LoadingScene.qml"

  Component.onCompleted: {
    // splash screen is special and gets loaded on startup!
    sceneLoader1.source = splashScene

    // faster debug
    //sceneLoader1.source = gameScene

    sceneLoader1.activateScene()
  }

  Loader {
    id: sceneLoader1

    property bool busy: true

    onSourceChanged: {
      if(item) {
        activeScene = item
        activeScene.initScene()
      }
      loadItemWithCocos(sceneLoader1)
      //console.log("[SceneLoader1] Loaded scene ", utils.cropPath(sceneLoader1.source, true),sceneLoader1.busy)
    }

    function activateScene() {
      if(item) {
        // fade in
        item.open()
        // set flag to indicate that this loaded is busy
        sceneLoader1.busy = true
        //console.log("[SceneLoader1] Activated scene ", utils.cropPath(sceneLoader1.source, true),sceneLoader1.busy)
      } else {
        console.log("[SceneLoader1] WARNING: Scene item not loaded ", utils.cropPath(sceneLoader1.source, true),sceneLoader1.busy)
      }
    }

    function deactivateScene() {
      if(item) {
        // This closure will cause a visible changed signal
        item.close()
        //console.log("[SceneLoader1] Closed scene ", utils.cropPath(sceneLoader1.source, true),sceneLoader1.busy)
      } else {
        console.log("[SceneLoader1] WARNING: Scene to close not present ", utils.cropPath(sceneLoader1.source, true),sceneLoader1.busy)
      }
    }

    Connections {
      target: sceneLoader1.item
      onVisibleChanged: {
        // last scene is not visible anymore, fade in next scene!
        if(!sceneLoader1.item.visible) {
          //console.log("[SceneLoader1] Scene deactivated and activate next scene ", utils.cropPath(sceneLoader1.source, true),sceneLoader1.busy)
          sceneLoader1.busy = false
          sceneLoader2.activateScene()
          //sceneLoader1.source = ""
        }
      }
    }
  }

  Loader {
    id: sceneLoader2

    property bool busy: true

    onSourceChanged: {
      if(item) {
        activeScene = item
        activeScene.initScene()
      }
      loadItemWithCocos(sceneLoader2)
      //console.log("[SceneLoader2] Loaded scene ", utils.cropPath(sceneLoader2.source, true),sceneLoader2.busy)
    }

    function activateScene() {
      if(item) {
        // fade in
        item.open()
        // set flag to indicate that this loaded is busy
        sceneLoader2.busy = true

        //console.log("[SceneLoader2] Activated scene ", utils.cropPath(sceneLoader2.source, true),sceneLoader2.busy)
      } else {
        console.log("[SceneLoader2] WARNING: Scene item not loaded ", utils.cropPath(sceneLoader2.source, true),sceneLoader2.busy)
      }
    }

    function deactivateScene() {
      if(item) {
        // This closure will cause a visible changed signal
        item.close()
        //console.log("[SceneLoader2] Closed scene ", utils.cropPath(sceneLoader2.source, true),sceneLoader2.busy)
      } else {
        console.log("[SceneLoader2] WARNING: Scene to close not present ", utils.cropPath(sceneLoader2.source, true),sceneLoader2.busy)
      }
    }

    Connections {
      target: sceneLoader2.item
      onVisibleChanged: {
        // last scene is not visible anymore, fade in next scene!
        if(!sceneLoader2.item.visible) {
          //console.log("[SceneLoader2] Scene deactivated and activate next scene ", utils.cropPath(sceneLoader2.source, true),sceneLoader2.busy)
          sceneLoader2.busy = false
          sceneLoader1.activateScene()
          //sceneLoader2.source = ""
        }
      }
    }
  }

  function loadWithFreeLoader(newSource) {
    if(sceneLoader1.busy) {
      sceneLoader2.source = newSource
      sceneLoader1.deactivateScene()
    } else if(sceneLoader2.busy){
      sceneLoader1.source = newSource
      sceneLoader2.deactivateScene()
    } else {
      console.log("[SceneLoader] WARNING: All scenes are unbusy?")
    }
  }


  function activateWarningScene() {
    loadWithFreeLoader(warningScene)
  }

  function activateIntroScene() {
    loadWithFreeLoader(introScene)
  }

  function activateMainMenuScene() {
    loadWithFreeLoader(mainMenuScene)
  }

  function activateCreditsScene() {
    loadWithFreeLoader(creditsScene)
  }

  function activateOptionsScene() {
    loadWithFreeLoader(optionScene)
  }

  function activateGameScene() {
    loadWithFreeLoader(gameScene)
  }

  function activateGameOverScene() {
    loadWithFreeLoader(gameOverScene)
  }

  function activateLoadingScene() {
    loadWithFreeLoader(loadingScene)
  }
}

