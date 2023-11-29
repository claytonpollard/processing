ArrayList<Strike> strikes = new ArrayList<Strike>();
ArrayList<Rain> drops = new ArrayList<Rain>();
ArrayList<Cloud> clouds = new ArrayList<Cloud>();

float[] plusMinus = {-1, 1};

float tick = 0;
float flashTick = -60;

float mXDir;
float mYDir;

int rainIntensity = 15;
int strikeCloudAmount = 50;

float xShake;
float yShake;

float lInter(float a, float b, float t) {
  return (a + (b - a) * t);
}

void setup() {
  size(1500, 640);
  noStroke();
  surface.setLocation(width / 8, height / 4);
  surface.setTitle("'thunderstorm' by sktic");
  
  mXDir = (mouseX - (width / 2)) / 30;
}

void draw() {
  surface.setLocation((width / 8) + int(xShake), (height / 4) + int(yShake));
  xShake *= -0.92;
  yShake *= -0.92;
  
  tick++;
  background(0);
  
  strokeWeight(3);
  stroke(255, 0, 0);
  //line(mouseX, -height * 0.5, mouseX, height * 1.5);
  noStroke();
  
  mXDir = lInter(mXDir, (mouseX - (width / 2)) / 30, 0.05);
  
  rainIntensity = int(lInter(float(rainIntensity), 1 + (mouseY / 15), 0.05));
  
  for (int i = 0; i < rainIntensity; i++) {
    drops.add(new Rain(int(random(-width * 2, width * 2)), -height / 8, mXDir, random(15,30)));
  }
  
  for (int i = drops.size() - 1; i >= 0; i--) {
    Rain drop = drops.get(i);
    drop.update();
    drop.display();
    if (drop.dead()) {
      drops.remove(i);
    }
  }
  
  if ((tick - flashTick) <= 7) {
    background(255);
  }
  
  for (int i = 0; i < clouds.size(); i++) {
    Cloud cloud = clouds.get(i);
    cloud.update();
    cloud.display();
    if (cloud.dead()) {
      clouds.remove(i);
    }
  }
  
  for (int i = strikes.size() - 1; i >= 0; i--) {
    Strike strike = strikes.get(i);
    strike.update();
    strike.display();
    if (strike.done()) {
     // print("removing");
      strikes.remove(i);
    }
  }
}

int idx;

void windowShake(float x, float y) {
  xShake = x;
  yShake = y;
}

void mousePressed() {
  idx++;
  flashTick = tick;
  int mX = mouseX;
  float rWidth = random(100, 120);
  strikes.add(new Strike(mX, rWidth, int(random(0,30))));
  float predet = random(20, 30);
  float predet2 = random(20, 30);
  windowShake(plusMinus[int(random(0, plusMinus.length))] * random(20, 40), plusMinus[int(random(0, plusMinus.length))] * random(20, 40));
  for (Strike strike : strikes) {
  // strike.shake(predet, predet2);
  }
  for (int i = 0; i < strikeCloudAmount; i++) {
    clouds.add(new Cloud(mX, height, plusMinus[int(random(0, plusMinus.length))] * random(10,30), random(-30, -5), random(20, 40), random(0.9, 0.97)));
  }
}
