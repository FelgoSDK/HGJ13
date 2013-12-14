var NUM_ROCKETS = 5;
var rocketUrl = Qt.resolvedUrl("../entities/Rocket.qml");
var objects = {};
var objectsCount = 0;
var gravityWells = [];
var impulse = Qt.point(0,0);
var objectSettings =  {"x": 0,
  "y": 0,
  "rotation": 60,
  "target": null
}

function init() {
}

function createRockets(target) {
  for(var i = 0; i < NUM_ROCKETS; i++) {
    var randomPosX = generateRandomValueBetween(20, level.width-20);
    var randomPosY = generateRandomValueBetween(20, level.height-20);
    objectSettings.x = randomPosX;
    objectSettings.y = randomPosY;
    objectSettings.target = target;
    var entityId = entityManager.createEntityFromUrlWithProperties(rocketUrl, objectSettings);
    addObject(entityId);
  }
}

function setGravityWells(wells) {
  gravityWells = wells;
}

function generateRandomValueBetween(minimum, maximum) {
  return Math.random()*(maximum-minimum) + minimum;
}

function addObject(entityId) {
  objects[entityId] = entityManager.getEntityById(entityId);
  objectsCount++;
}

function removeObject(entityId) {
  delete objects[entityId];
  objectsCount--
}

function applyGravity() {
  for(var i = 0; i < gravityWells.length; ++i) {
    var gravityPosition = gravityWells[i].getPosition();
    for(var j in objects) {
      var object = objects[j];

      if(object.getPosition) {
        var objectPosition = object.getPosition();
        var dx = gravityPosition.x - objectPosition.x;
        var dy = gravityPosition.y - objectPosition.y;
        var distance = dx*dx + dy*dy;
        var angle = Math.atan2(dy, dx);

        impulse.x = 10*Math.cos(angle);
        impulse.y = 10*Math.sin(angle);
        object.applyGravityImpulse(impulse);
      }
    }
  }
}
