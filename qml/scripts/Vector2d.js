function Vector2d(x, y) {
	this.set(x, y);
}

Vector2d.prototype.set = function() {
	if (arguments[0] === undefined) {
		this.x = 0;
		this.y = 0;
	} else if (arguments[1] === undefined) {
		this.x = parseFloat(arguments[0].x);
		this.y = parseFloat(arguments[0].y);
	} else {
		this.x = parseFloat(arguments[0]);
		this.y = parseFloat(arguments[1]);
	}
};

Vector2d.prototype.clone = function() {
  return new Vector2d(this);
};

Vector2d.prototype.addLocal = function(other) {
	this.x += other.x;
	this.y += other.y;
	return this;
};

Vector2d.prototype.add = function(other) {
  return Vector2d.add(this, other);
};

Vector2d.add = function(vectorA, vectorB) {
	return vectorA.clone().addLocal(vectorB);
};

Vector2d.prototype.subtractLocal = function(other) {
	this.x -= other.x;
	this.y -= other.y;
	return this;
};

Vector2d.prototype.subtract = function(other) {
  return Vector2d.subtract(this, other);
};

Vector2d.subtract = function(vectorA, vectorB) {
	return vectorA.clone().subtractLocal(vectorB);
};

Vector2d.prototype.multiply = function(value) {
	return this.clone().multiplyLocal(value);
};

Vector2d.prototype.multiplyLocal = function(value) {
	this.x *= value;
	this.y *= value;
	return this;
};

Vector2d.prototype.divide = function(value) {
	return this.clone().divideLocal(value);
};

Vector2d.prototype.divideLocal = function(value) {
	this.x /= value;
	this.y /= value;
	return this;
};

Vector2d.prototype.lengthSquared = function() {
	return this.x * this.x + this.y * this.y;
};

Vector2d.prototype.length = function() {
	return Math.sqrt(this.lengthSquared());
};

Vector2d.prototype.dotProduct = function(other) {
	return this.x * other.x + this.y * other.y;
};

Vector2d.prototype.normalize = function() {
	return this.divide(this.length());
};

Vector2d.prototype.normalizeLocal = function() {
	return this.divideLocal(this.length());
};
