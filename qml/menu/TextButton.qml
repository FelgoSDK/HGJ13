import VPlay 1.0
import QtQuick 1.1

Item {
  id: button

  property string text: ""
  property string textColor: "#68090F"
  property string textColorShadow: "#D3AF1A"
  property variant font
  property int textSize: 170/4
  property int offsetX: 3
  property int offsetY: 3

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
    id: textShadow
    x: text.x+button.offsetX
    y: text.y+button.offsetY
    //z:2
    font.family: button.font ? button.font.name : fontHUD.name
    text: button.text
    color: button.textColorShadow
    font.pixelSize: button.textSize
  }


  Text {
    id: text
    //z:2
    font.family: button.font ? button.font.name : fontHUD.name
    text: button.text
    color: button.textColor
    font.pixelSize: button.textSize
    //anchors.centerIn: button
  }

  onClicked: {
  }

  onPressed: {
    opacity = 0.5
  }

  onReleased: {
    opacity = 1.0
  }

  Timer {
    id: randomColorTimer
    interval: 200
    repeat: true
    onTriggered: textShadow.color = getRandomColor()
  }

  Component.onCompleted: randomColorTimer.start()

  function getRandomColor() {
      var letters = '0123456789ABCDEF'.split('');
      var color = '#';
      for (var i = 0; i < 6; i++ ) {
          color += letters[Math.round(Math.random() * 15)];
      }
      return color;
  }
}
