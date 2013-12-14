import VPlay 1.0
import QtQuick 1.1

EntityBase {
  function getPosition() {
    return collider.body.getWorldCenter()
  }

  function applyGravityImpulse(forward) {
    collider.body.applyLinearImpulse(forward, getPosition())
  }
}
