var NUM_ROCKETS = 5;
var rocketUrl = Qt.resolvedUrl("../entities/Rocket.qml");
var satelliteUrl = Qt.resolvedUrl("../entities/Satellite.qml");
var cometUrl = Qt.resolvedUrl("../entities/Comet.qml");
var objects = {};
var objectsCount = 0;
var players = {};
var gravityWells = {};
var earthId = "";
var direction = Qt.point(0,0);
var satelliteOrbits = [];
var satelliteAlive = {};
var objectSettings = {
  "x": 0,
  "y": 0,
  "rotation": 60,
  "collisionGroup": 0,
  "variationType": 1
}
var satelliteSettings =  {
  "origin" : Qt.point(0, 0),
  "x": 0,
  "y": 0,
  "angle": 0,
  "distance": 0,
  "speed": 0,
  "index": 0
}
var cometSettings = {
  "x": 0,
  "y": 0,
  "rotation": 0,
}

function init(orbits) {
  for(var i = 0; i < orbits.length; ++i) {
    satelliteAlive[i] = false;
  }
  satelliteOrbits = orbits;
}

function setPlayers(player1, player2) {
  players[player1.entityId] = player1;
  players[player2.entityId] = player2;
}

function spawnSatellite() {
  var distance = 0;
  var index = 0;
  for(var i = 0; i < satelliteOrbits.length; ++i) {
    if(!satelliteAlive[i]) {
      distance = satelliteOrbits[i];
      index = i;
      satelliteAlive[i] = true;
      break;
    }
  }

  var well = entityManager.getEntityById(earthId);
  if(well) {
    satelliteSettings.origin = well.getPosition();
    satelliteSettings.x = satelliteSettings.origin.x;
    satelliteSettings.y = satelliteSettings.origin.y;
    satelliteSettings.index = index;
    satelliteSettings.angle = Math.random() * Math.PI * 2
    satelliteSettings.distance = distance;
    satelliteSettings.speed = Math.random() * 0.02 + 0.01;
    if(Math.random() < 0.5) {
      satelliteSettings.speed *= -1;
    }

    entityManager.createEntityFromUrlWithProperties(satelliteUrl, satelliteSettings);
  }
}

function spawnComet() {
  var x = Math.random() * 440 + 20;
  var y = (Math.random() < 0.5) ? 400 : -80;

  cometSettings.x = x;
  cometSettings.y = y;
  cometSettings.rotation = Math.random() * 360;

  //console.debug(cometSettings.x, cometSettings.y, cometSettings.angle, cometSettings.speed)
  var entityId = entityManager.createEntityFromUrlWithProperties(cometUrl, cometSettings);


  var well = entityManager.getEntityById(earthId);
  if(well) {
    var center = well.getPosition();
    var comet = entityManager.getEntityById(entityId);
    var dx = center.x - x;
    var dy = center.y - y;
    var angle = Math.atan2(dy, dx);

    var divergence = (Math.random() * 15 + 20) * Math.PI / 180;
    if(Math.random() < 0.5) {
      divergence *= -1;
    }
    angle += divergence;
    var speed = Math.random() * 50 + (45 - divergence) * 4;
    direction.x = Math.cos(angle) * speed;
    direction.y = Math.sin(angle) * speed;
    comet.applyImpulse(direction);
  }
  addObject(entityId);
}

function spawnRocket(playerId) {
  var player = entityManager.getEntityById(playerId);
  objectSettings.collisionGroup = player.collisionGroup;
  objectSettings.x = player.x + player.weaponPosition.x;
  objectSettings.y = player.y + player.weaponPosition.y;
  objectSettings.rotation = player.rotation + player.weaponAngle;
  objectSettings.variationType = playerId
  var entityId = entityManager.createEntityFromUrlWithProperties(rocketUrl, objectSettings);
  addObject(entityId);
}

function setGravityWells(wells) {
  for(var i = 0; i < wells.length; ++i) {
    var well = wells[i];
    if(i === 0) {
      earthId = well.entityId;
    }
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

function removeSatellite(index) {
  satelliteAlive[index] = false;
}

function removeObject(entityId) {
  if(objects[entityId]){
    objectsCount--;
  }
  delete objects[entityId];
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
