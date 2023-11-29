let dots = [];
let balls = [];
let canBall;
let ballSpeed;

function setup() {
  createCanvas(1000, 1000);
  colorMode(HSB);
  ballSpeed = 350;
  canBall = true;
}

function draw() {
  background(0);
  strokeWeight(2);

  // Draw lines between all dots
  for (let k = 0; k < dots.length; k++) {
    for (let j = 0; j < dots.length; j++) {
      if (k != j) {
        let avgCol = lerpColor(dots[k].col, dots[j].col, 0.5); // Averaging the colors
        stroke(avgCol);
        line(dots[k].x, dots[k].y, dots[j].x, dots[j].y);
      }
    }
  }

  // Draw a circle at the mouse position when pressed
  if (mouseIsPressed) {
    fill(255);
    noStroke();
    circle(mouseX, mouseY, 10);
  }

  // Render dots
  dots.forEach((dot) => {
    dot.render();
  });

  // Add a new ball if conditions are met
  if (dots.length >= 2 && canBall) {
    balls.push(new Ball(ballSpeed, 15, 0, 1));
    canBall = false;
  }

  // Update and draw balls
  balls.forEach((ball) => {
    ball.follow();
    if (ball.dupe) {
      let dot2Temp = floor(random(dots.length));
      dot2Temp = ball.getNewDot(dot2Temp);
      balls.push(new Ball(ballSpeed, 15, ball.dotGet1, dot2Temp));
    }
  });
}

function mouseReleased() {
  dots.push(new Dot(mouseX, mouseY, color(random(255), 255, 255)));
}

function keyPressed() {
  dots = [];
  balls = [];
  canBall = true;
}

class Ball {
  constructor(speed, size, dotGet1, dotGet2) {
    this.speed = speed;
    this.size = size;
    this.dotGet1 = dotGet1;
    this.dotGet2 = dotGet2;
    this.dupe = false;
    this.col = color(0);
    this.x = 0;
    this.y = 0;
    this.dx = 0;
    this.dy = 0;
    this.counter = 0;
  }

  follow() {
    let dot1 = dots[this.dotGet1];
    let dot2 = dots[this.dotGet2];

    this.dx = dot2.x - dot1.x;
    this.dy = dot2.y - dot1.y;
    this.col = lerpColor(dot1.col, dot2.col, 0.5); // Averaging the colors

    this.x = dot1.x + (this.counter * this.dx) / this.speed;
    this.y = dot1.y + (this.counter * this.dy) / this.speed;

    if (this.counter === this.speed) {
      this.dotGet1 = this.dotGet2;
      this.dotGet2 = floor(random(dots.length));
      this.dotGet2 = this.getNewDot(this.dotGet2);
      this.counter = 0;
      this.dupe = true;
    } else {
      this.dupe = false;
    }

    fill(this.col);
    noStroke();
    circle(this.x, this.y, this.size);
    this.counter++;
  }

  getNewDot(dot2Temp) {
    if (dot2Temp === this.dotGet1 || dot2Temp >= dots.length) {
      dot2Temp = (this.dotGet1 + 1) % dots.length;
    }
    return dot2Temp;
  }
}

class Dot {
  constructor(x, y, col) {
    this.x = x;
    this.y = y;
    this.col = col;
  }

  render() {
    fill(this.col);
    noStroke();
    circle(this.x, this.y, 10);
  }
}
