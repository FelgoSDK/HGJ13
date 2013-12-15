import VPlay 1.0
import QtQuick 1.1

SingleSpriteFromFile {
  property string variationType: "1"

  filename: "../img/images-sd.json"
  source: "shield" + variationType + ".png"
  translateToCenterAnchor: false
}
