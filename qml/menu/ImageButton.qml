import VPlay 1.0
import QtQuick 1.1

SingleSpriteFromFile {
  id: button
  filename: "../img/images-sd.json"
  translateToCenterAnchor: false
  source: "options.png"

  signal clicked
  signal pressed
  signal released

  MouseArea {
    id: mouseArea
    anchors.fill: button
    hoverEnabled: true

    onClicked: button.clicked()
    onPressed: button.pressed()
    onReleased: button.released()
  }

  onClicked: {
  }

  onPressed: {
    opacity = 0.5
  }

  onReleased: {
    opacity = 1.0
  }
}
