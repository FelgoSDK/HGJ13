var NUM_PEDESTRIANS = 30

function init() {
  createPedestrians()
}

function createPedestrians() {
  for(var i = 0; i < NUM_PEDESTRIANS; i++) {
    var randomPosX = generateRandomValueBetween(20, level.width-20)
    var randomPosY = generateRandomValueBetween(20, level.height-20)

    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Pedestrian.qml"),
                                                    {"x": randomPosX,
                                                      "y": randomPosY
                                                    });
  }
}

function generateRandomValueBetween(minimum, maximum) {
  return Math.random()*(maximum-minimum) + minimum
}
