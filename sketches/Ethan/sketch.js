// Global variables
let strikes = [];
let drops = [];
let clouds = [];

let plusMinus = [-1, 1];

let tick = 0;
let flashTick = -60;

let mXDir;
let rainIntensity = 15;
let strikeCloudAmount = 50;

let xShake = 0;
let yShake = 0;

function setup() {
  createCanvas(1500, 640);
  noStroke();
  mXDir = (mouseX - width / 2) / 30;
}

function draw() {
  tick++;
  background(0);

  mXDir = lerp(mXDir, (mouseX - width / 2) / 30, 0.05);
  rainIntensity = lerp(rainIntensity, 1 + mouseY / 15, 0.05);

  // Generate rain
  for (let i = 0; i < rainIntensity; i++) {
    drops.push(
      new Rain(
        random(-width * 2, width * 2),
        -height / 8,
        mXDir,
        random(15, 30)
      )
    );
  }

  // Update and draw rain
  for (let i = drops.length - 1; i >= 0; i--) {
    let drop = drops[i];
    drop.update();
    drop.display();
    if (drop.dead()) {
      drops.splice(i, 1);
    }
  }

  // Lightning flash
  if (tick - flashTick <= 7) {
    background(255);
  }

  // Update and draw clouds
  for (let i = clouds.length - 1; i >= 0; i--) {
    let cloud = clouds[i];
    cloud.update();
    cloud.display();
    if (cloud.dead()) {
      clouds.splice(i, 1);
    }
  }

  // Update and draw strikes
  for (let i = strikes.length - 1; i >= 0; i--) {
    let strike = strikes[i];
    strike.update();
    strike.display();
    if (strike.done()) {
      strikes.splice(i, 1);
    }
  }
}

function mousePressed() {
  flashTick = tick;
  let mX = mouseX;
  let rWidth = random(100, 120);
  strikes.push(new Strike(mX, rWidth, random(0, 30)));

  windowShake(
    random(plusMinus) * random(20, 40),
    random(plusMinus) * random(20, 40)
  );
  for (let i = 0; i < strikeCloudAmount; i++) {
    clouds.push(
      new Cloud(
        mX,
        height,
        random(plusMinus) * random(10, 30),
        random(-30, -5),
        random(20, 40),
        random(0.9, 0.97)
      )
    );
  }
}

function windowShake(x, y) {
  xShake = x;
  yShake = y;
}

class Strike {
  constructor(xInit, scaleInit, tickInit) {
    this.xPos = xInit;
    this.yPos = 0;
    this.scale = scaleInit;
    this.miniScale = this.scale * 0.35;
    this.scaleO = this.scale;
    this.miniScaleO = this.miniScale;
    this.tick = tickInit;
    this.xOffset = 0;
    this.yOffset = 0;
  }

  update() {
    this.tick++;
    this.scale *= 0.92;
    this.miniScale *= 0.95;
    this.xOffset *= -0.85;
    this.yOffset *= -0.85;
  }

  display() {
    fill(255, 230, 100, 750 * (this.scale / this.scaleO));
    rect(
      this.xPos - this.scale / 2 + this.xOffset,
      this.yPos + this.yOffset - height / 4,
      this.scale,
      height * 1.5
    );
    fill(255, 255, 255, 750 * (this.miniScale / this.miniScaleO));
    rect(
      this.xPos - this.miniScale / 2 + this.xOffset,
      this.yPos + this.yOffset - height / 4,
      this.miniScale,
      height * 1.5
    );
  }

  done() {
    return this.scale < 2;
  }
}

class Cloud {
  constructor(xOrgInit, yOrgInit, xDirInit, yDirInit, scaleInit, deAccInit) {
    this.xOrg = xOrgInit;
    this.yOrg = yOrgInit;
    this.xDir = xDirInit;
    this.yDir = yDirInit;
    this.scale = scaleInit;
    this.oScale = this.scale;
    this.deAccel = deAccInit;
    this.x = -this.xDir * 5;
    this.y = -this.yDir * 5;
    this.grav = 1;
    this.tick = 0;
  }

  update() {
    this.tick++;
    this.x += this.xDir;
    this.y += this.yDir;
    this.xDir *= this.deAccel;
    this.yDir *= this.deAccel;
    this.scale *= 0.97;
    this.grav *= 1.05;
  }

  display() {
    fill(255 * ((this.scale / this.oScale) * 2) + 100);
    ellipse(
      this.xOrg + this.x,
      this.yOrg + this.y + this.grav,
      this.scale,
      this.scale
    );
  }

  dead() {
    return this.scale < 2;
  }
}

class Rain {
  constructor(xInit, yInit, xDirInit, yDirInit) {
    this.len = random(4, 8);
    this.xOrg = xInit;
    this.yOrg = yInit;
    this.xDir = xDirInit;
    this.yDir = yDirInit;
    this.x1 = this.xOrg;
    this.y1 = this.yOrg;
    this.x2 = this.xOrg + this.xDir * this.len;
    this.y2 = this.yOrg + this.yDir * this.len;
    this.tick = 0;
  }

  update() {
    this.x1 += this.xDir;
    this.x2 += this.xDir;
    this.y1 += this.yDir;
    this.y2 += this.yDir;
  }

  display() {
    strokeWeight(3);
    stroke(255 * (this.len / 8));
    line(this.x1, this.y1, this.x2, this.y2);
    noStroke();
  }

  dead() {
    return (
      this.x2 > width * 1.5 ||
      this.x2 < -(width * 1.5) ||
      this.y2 > height * 1.5 ||
      this.y2 < -(height * 1.5)
    );
  }
}
