var fuses;
var particles;
var explosions;
var startX, startY;

function setup() {
  frameRate(60);
  size(1280, 720);
  
  fuses = [];
  particles = [];
  explosions = [];
  
  colorMode(HSB);
}

function draw() {
  background(0);
  
  if (mousePressed) {
    stroke(255);
    strokeWeight(height / 200);
    line(startX, startY, mouseX, mouseY);
  } else {
    startX = mouseX;
    startY = mouseY;
  }
  
  for (var i = fuses.length - 1; i >= 0; i--) {
    var fuse = fuses[i];
    fuse.step();
    if (fuse.done()) { 
      fuses.splice(i, 1); 
    }
  }

  for (var i = particles.length - 1; i >= 0; i--) {
    var particle = particles[i];
    particle.step();
    if (particle.done()) { 
      particles.splice(i, 1); 
    }
  }

  for (var i = explosions.length - 1; i >= 0; i--) {
    var explosion = explosions[i];
    explosion.step();
    if (explosion.done()) { 
      explosions.splice(i, 1); 
    }
  }
}

function mouseReleased() {
  fuses.push(new Fuse(color(random(0, 255), 255, 255), startX, startY, mouseX, mouseY));
}

// Fuse class
function Fuse(col, sx, sy, ex, ey) {
  this.sx = sx;
  this.sy = sy;
  this.ex = ex;
  this.ey = ey;
  this.col = col;
  this.maxTime = 100 * ceil(sqrt(sq(ex - sx) + sq(ey - sy))) / height;
  this.time = this.maxTime;

  this.step = function() {
    this.time -= 1;
    stroke(255);
    strokeWeight(height / 200);
    line(this.sx + (this.ex - this.sx) * map(this.time, this.maxTime, 0, 0, 1), this.sy + (this.ey - this.sy) * map(this.time, this.maxTime, 0, 0, 1), this.ex, this.ey);
    noStroke();
    fill(this.col);
    circle(this.ex, this.ey, height / 50);
    particles.push(new Particle(this.col, this.sx + (this.ex - this.sx) * map(this.time, this.maxTime, 0, 0, 1), this.sy + (this.ey - this.sy) * map(this.time, this.maxTime, 0, 0, 1)));
    particles.push(new Particle(this.col, this.sx + (this.ex - this.sx) * map(this.time + 0.3, this.maxTime, 0, 0, 1), this.sy + (this.ey - this.sy) * map(this.time + 0.3, this.maxTime, 0, 0, 1)));
    particles.push(new Particle(this.col, this.sx + (this.ex - this.sx) * map(this.time - 0.3, this.maxTime, 0, 0, 1), this.sy + (this.ey - this.sy) * map(this.time - 0.3, this.maxTime, 0, 0, 1)));
  }

  this.done = function() {
    if (this.time <= 0) {
      for (var i = 0; i < 500; i++) {
        explosions.push(new Explosion(this.col, this.maxTime, this.ex, this.ey));
      }
      return true;
    } else {
      return false;
    }
  }
}

// Explosion class
function Explosion(col, maxTime, x, y) {
  this.x = x;
  this.y = y;
  this.time = maxTime;
  this.col = col;
  this.movement = new PVector(random(-1, 1), random(-1, 1));
  this.movement.normalize();
  this.movement.x *= random(0, 5);
  this.movement.y *= random(0, 5);

  this.step = function() {
    this.time -= 1;
    this.x += this.movement.x;
    this.y += this.movement.y;
    this.movement.x += 1.2 * (noise(random(1000)) - 0.455);
    this.movement.y += 1.2 * (noise(random(1000)) - 0.455);
    noStroke();
    fill(this.col, map(this.time, 200, 0, 255, 0) + 150 * (noise(random(1000)) - 0.5));
    circle(this.x + noise(this.time) - 0.5, this.y + noise(this.time) - 0.5, height / 50);
  }

  this.done = function() {
    return this.time <= 0;
  }
}

// Particle class
function Particle(col, x, y) {
  this.time = 10;
  this.x = x;
  this.y = y;
  this.col = col;

  this.step = function() {
    this.time -= 1;
    noStroke();
    fill(this.col, this.time * 127 / 8);
    circle(this.x + (noise(this.x) - 0.5) * 10, this.y + (noise(this.y) - 0.5) * 10, height / 80);
  }

  this.done = function() {
    return this.time <= 0;
  }
}
