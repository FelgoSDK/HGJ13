import VPlay 1.0
import QtQuick 1.1

import "manager"

GameWindow {
  id: window
  width: 480
  height: 320


  minimizeable: true
  maximizeable:  true
  fullscreen: true

  // this would disable the fps label both for QML & cocos renderer - if only qml renderer should be disabled use fpsTextItem.visible: false
  displayFpsEnabled: false //developerBuild

  // in the developer version, the fps are displayed
  property bool developerBuild: !system.publishBuild

  // forward events always to the controller of the loaded active scene
  Keys.forwardTo: activeScene.controllerOfScene

  // sceneLoader and managers should be available in every scene
  property alias window: window
  property alias audioManager: audioManager
  property alias settingsManager: settingsManager
  property alias entityManager: entityManager
  property alias sceneLoader: sceneLoader
  property alias fontHUD: fontHUD

  // Custom font loading of ttf fonts
  FontLoader {
    id: fontHUD
    source: "fonts/04B_03__.ttf"
  }

  FontLoader {
    id: fontLetterHUD
    source: "fonts/propaganda.ttf"
  }

  // global music and sound management
  AudioManager {
    id: audioManager
  }

  // settings can be stored directly by the settings manager
  SettingsManager {
    id: settingsManager
  }

  // all content is loaded dynamically by the sceneLoader element.
  SceneLoader {
    id: sceneLoader
  }

  EntityManager {
    id: entityManager
    // forward container allways to container of scene
    entityContainer: activeScene.entityContainerOfScene
    // forward dynamic entity list e.g. used for level editor
    //dynamicCreationEntityList: activeScene.dynamicCreationEntityList
  }
}
