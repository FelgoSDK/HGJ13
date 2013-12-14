import VPlay 1.0
import QtQuick 1.1

EntityBase {
  function getPosition() {
    return collider.body.getWorldCenter()
  }

  function applyGravity(direction) {
    collider.body.applyForce(direction, getPosition())
  }
}
