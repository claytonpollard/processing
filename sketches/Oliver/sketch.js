// Define the arrays
let fuses = [];
let particles = [];
let explosions = [];

// Mouse start position
let startX, startY;

function setup() {
  createCanvas(1920, 1080);
  frameRate(60);
  colorMode(HSB);
  startX = 0;
  startY = 0;
}

function draw() {
  background(0);

  if (mouseIsPressed) {
    stroke(255);
    strokeWeight(height / 200);
    line(startX, startY, mouseX, mouseY);
  } else {
    startX = mouseX;
    startY = mouseY;
  }

  // Update fuses
  for (let i = fuses.length - 1; i >= 0; i--) {
    fuses[i].step();
    if (fuses[i].done()) {
      fuses.splice(i, 1);
    }
  }

  // Update particles
  for (let i = particles.length - 1; i >= 0; i--) {
    particles[i].step();
    if (particles[i].done()) {
      particles.splice(i, 1);
    }
  }

  // Update explosions
  for (let i = explosions.length - 1; i >= 0; i--) {
    explosions[i].step();
    if (explosions[i].done()) {
      explosions.splice(i, 1);
    }
  }
}

function mouseReleased() {
  fuses.push(
    new Fuse(color(random(0, 255), 255, 255), startX, startY, mouseX, mouseY)
  );
}

class Explosion {
  constructor(col, maxTime, x, y) {
    this.x = x;
    this.y = y;
    this.time = maxTime * 2;
    this.col = col;
    this.movement = createVector(random(-1, 1), random(-1, 1));
    this.movement.normalize();
    this.movement.mult(random(0, 5));
  }

  step() {
    this.time--;
    this.x += this.movement.x;
    this.y += this.movement.y;
    this.movement.x += 1.2 * (noise(random(1000)) - 0.455);
    this.movement.y += 1.2 * (noise(random(1000)) - 0.455);

    noStroke();
    fill(
      this.col,
      map(this.time, 200, 0, 255, 0) + 150 * (noise(random(1000)) - 0.5)
    );
    circle(
      this.x + noise(this.time) - 0.5,
      this.y + noise(this.time) - 0.5,
      height / 50
    );
  }

  done() {
    return this.time <= 0;
  }
}

class Fuse {
  constructor(col, sx, sy, ex, ey) {
    this.sx = sx;
    this.sy = sy;
    this.ex = ex;
    this.ey = ey;
    this.col = col;
    this.maxTime = (100 * ceil(sqrt(sq(ex - sx) + sq(ey - sy)))) / height;
    this.time = this.maxTime;
  }

  step() {
    this.time--;

    stroke(255);
    strokeWeight(height / 200);
    line(
      this.sx + (this.ex - this.sx) * map(this.time, this.maxTime, 0, 0, 1),
      this.sy + (this.ey - this.sy) * map(this.time, this.maxTime, 0, 0, 1),
      this.ex,
      this.ey
    );
    noStroke();
    fill(this.col);
    circle(this.ex, this.ey, height / 50);

    particles.push(
      new Particle(
        this.col,
        this.sx + (this.ex - this.sx) * map(this.time, this.maxTime, 0, 0, 1),
        this.sy + (this.ey - this.sy) * map(this.time, this.maxTime, 0, 0, 1)
      )
    );
    // You can add more particles as in your original code
  }

  done() {
    if (this.time <= 0) {
      for (let i = 0; i < 500; i++) {
        explosions.push(
          new Explosion(this.col, this.maxTime, this.ex, this.ey)
        );
      }
      return true;
    } else {
      return false;
    }
  }
}

class Particle {
  constructor(col, x, y) {
    this.time = 10;
    this.x = x;
    this.y = y;
    this.col = col;
  }

  step() {
    this.time--;
    noStroke();
    fill(this.col, (this.time * 127) / 8);
    circle(
      this.x + (noise(this.x) - 0.5) * 10,
      this.y + (noise(this.y) - 0.5) * 10,
      height / 80
    );
  }

  done() {
    return this.time <= 0;
  }
}
