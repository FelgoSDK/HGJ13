import VPlay 1.0
import QtQuick 1.1

Item {
  id: playerDragger

  signal moveNow
  signal releasedNow

  MultiTouchArea {
    id: touchArea
    width: 50
    height: 50
    anchors.centerIn: parent

    drag.target: parent

    drag.minimumX: width/2
    drag.maximumX: level.width-width/2
    drag.minimumY: height/2
    drag.maximumY: level.height-height/2


    onPositionChanged: {
      playerDragger.moveNow()
    }
    onReleased: {
      playerDragger.releasedNow()
    }
  }

  DebugVisual {
    width: touchArea.width
    height: touchArea.height
    anchors.centerIn: parent
  }
}
