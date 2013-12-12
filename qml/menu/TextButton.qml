import VPlay 1.0
import QtQuick 1.1

Item {
  id: button

  property string text: ""
  property string textColor: "#ffffff"
  property variant font
  property int textSize: 33

  signal clicked
  signal pressed
  signal released

  width: text.width
  height: text.height

  MouseArea {
    id: mouseArea
    enabled: button.enabled
    anchors.fill: button
    hoverEnabled: true

    onClicked: button.clicked()
    onPressed: button.pressed()
    onReleased: button.released()
  }

  Text {
    id: text
    z:2
    font.family: button.font ? button.font.name : fontHUD.name
    text: button.text
    color: button.textColor
    font.pixelSize: button.textSize
    anchors.centerIn: button
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
