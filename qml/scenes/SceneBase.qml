import QtQuick 1.1
import VPlay 1.0

// base component for all scenes in the game
Scene {
  id: sceneBase
  // this is important, as it serves as the reference size for the mass of the phyiscs objects, because the mass of a body depends on the width of its images
  width: 320
  height: 480

  // required by each scene which uses a controller
  property variant controllerOfScene: dummyController

  // required for entity manager to know where to put the entities to
  property variant entityContainerOfScene: sceneBase

  // required for LevelEditor, so the entities can be created by entityType by the entity manager
  property variant dynamicCreationEntityList: []

  // Dummy controller has not usage but it is needed so no errors occur on scenes where no controller was set.
  Item {
    id: dummyController
  }

  opacity: 0

  // this is an important performance improvement, as renderer can skip invisible items (and all its children)
  // also, the focus-property for key handling relies on the visible-property
  visible: opacity>0

  // size of one scene element
  gridSize: 32

  // handle this signal in each Scene
  signal backPressed

  function open() {
    opacity = 1;
  }

  function close() {
    opacity = 0;
  }

  function initScene() {

  }

  // this fades in and out automatically, when the opacity gets changed from 0 to 1
  Behavior on opacity {
    // the cross-fade animation should last 350ms
    NumberAnimation { duration: 450 }
  }

  Keys.onPressed: {
    if(event.key === Qt.Key_Backspace && system.desktopPlatform) {
      backPressed()
    }
  }

  Keys.onBackPressed: {
    backPressed()
  }
}
