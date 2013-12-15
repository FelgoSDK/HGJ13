import VPlay 1.0
import QtQuick 1.1

MultiResolutionImage {
  anchors.centerIn: parent


  Rectangle {
    id: backingLights
    z: parent.z-1
    anchors.fill: parent
    color: "green"
  }

  Timer {
    id: randomColorTimer
    interval: 50
    repeat: true
    onTriggered: backingLights.color = getRandomColor()
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
