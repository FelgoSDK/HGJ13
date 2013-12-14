var NUM_ROCKETS = 5;
var rocketUrl = Qt.resolvedUrl("../entities/Rocket.qml");
var obstacleUrl = Qt.resolvedUrl("../entities/Obstacle.qml");
var objects = {};
var objectsCount = 0;
var players = {};
var gravityWells = {};
var direction = Qt.point(0,0);
var objectSettings = {
  "x": 0,
  "y": 0,
  "rotation": 60,
  "target": null,
  "collisionGroup": 0
}
var obstacleSettings =  {
  "distance": 40,
  "speed": 0.005,
  "origin" : Qt.point(0, 0)
}

function init() {
}

function setPlayers(player1, player2) {
  players[player1.entityId] = player1;
  players[player2.entityId] = player2;
}

function spawnSatellite() {
  objectSettings.distance = Math.random() * 120 + 40;
  objectSettings.speed = Math.random() * 0.095 + 0.005;
  objectSettings.origin = gravityWells[0].getPosition();
  var entityId = entityManager.createEntityFromUrlWithProperties(obstacleUrl, obstacleSettings);
}

function spawnRocket(playerId) {
  var player = players[playerId];
  objectSettings.x = player.x + player.weaponPosition.x;
  objectSettings.y = player.y + player.weaponPosition.y;
  objectSettings.collisionGroup = player.collisionGroup;
  objectSettings.target = null;
  objectSettings.rotation = player.weaponAngle;
  var entityId = entityManager.createEntityFromUrlWithProperties(rocketUrl, objectSettings);
  addObject(entityId);
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
  for(var i = 0; i < wells.length; ++i) {
    var well = wells[i];
    gravityWells[well.entityId] = true;
  }
}

function generateRandomValueBetween(minimum, maximum) {
  return Math.random()*(maximum-minimum) + minimum;
}

function addObject(entityId) {
  objects[entityId] = true;
  objectsCount++;
}

function removeObject(entityId) {
  delete objects[entityId];
  objectsCount--
}

function applyGravity() {
  for(var wellId in gravityWells) {
    var well = entityManager.getEntityById(wellId);
    var gravityPosition = well.getPosition();
    for(var entityId in objects) {
      var object = entityManager.getEntityById(entityId);

      if(object && object.getPosition) {
        var objectPosition = object.getPosition();
        var dx = gravityPosition.x - objectPosition.x;
        var dy = gravityPosition.y - objectPosition.y;
        var distance = dx*dx + dy*dy;
        var angle = Math.atan2(dy, dx);

        var gravity = well.gravityForce / distance;
        direction.x = gravity * Math.cos(angle);
        direction.y = gravity * Math.sin(angle);
        object.applyGravity(direction);
      }
    }
  }
}
