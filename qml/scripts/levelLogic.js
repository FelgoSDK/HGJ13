var NUM_ROCKETS = 5

function init() {
}

function createRockets(target) {
  for(var i = 0; i < NUM_ROCKETS; i++) {
    var randomPosX = generateRandomValueBetween(20, level.width-20)
    var randomPosY = generateRandomValueBetween(20, level.height-20)

    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Rocket.qml"),
                                                    {"x": randomPosX,
                                                      "y": randomPosY,
                                                      "rotation": 60,
                                                      "target": target
                                                    });
  }
}

function generateRandomValueBetween(minimum, maximum) {
  return Math.random()*(maximum-minimum) + minimum
}
