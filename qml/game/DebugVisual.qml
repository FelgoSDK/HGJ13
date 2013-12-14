import VPlay 1.0
import QtQuick 1.1

SingleSpriteFromFile {
  filename: "../img/images-sd.json"
  source: "debugrect.png"
  translateToCenterAnchor: false
  opacity: 0.5
  visible: settingsManager.debugVisualsEnabled
}
