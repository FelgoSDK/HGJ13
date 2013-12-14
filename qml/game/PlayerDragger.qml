import VPlay 1.0
import QtQuick 1.1

MultiTouchArea {
  id: touchArea
  width: 50
  height: 50

  signal moveNow
  signal releasedNow

  drag.target: parent

  drag.minimumX: width/2
  drag.maximumX: level.width-width/2
  drag.minimumY: height/2
  drag.maximumY: level.height-height/2


  onPositionChanged: {
    touchArea.moveNow()
  }
  onReleased: {
    touchArea.releasedNow()
  }

  DebugVisual {
    width: touchArea.width
    height: touchArea.height
    anchors.centerIn: parent
  }
}
