import ddf.minim.*;

Minim minim;
AudioInput in;

float maxDist;
float time = 0;
float speed = 0.1;
float timeScale = 0.1;
float angularVelocity = 2.0;
float colorScaleR = 5;
float colorScaleG = 5; 
float colorScaleB = 10; 
float phaseShift = PI / 2;  // introduce a phase shift in frequency terms

void setup() {
  size(800, 800, P2D);
  maxDist = dist(0, 0, width / 2, height / 2);
  noFill();
  frameRate(60);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 1024);
}

void draw() {
  background(map(mouseX, 0, width, 0, 255), map(mouseY, 0, height, 0, 255), 150);
  time += speed;

  float sum = 0;
  for (int i = 0; i < in.bufferSize(); i++) {
    sum += abs(in.mix.get(i));
  }
  float averageAmplitude = sum / in.bufferSize();

  float brightnessValue = map(averageAmplitude, 0, 1, 0, 64);
  background(brightnessValue * 100, brightnessValue * 100, brightnessValue * 100, brightnessValue);

  speed = map(averageAmplitude, 0, 1, 0, 0.5);

  for (int y = 0; y < height; y += 10) {
    for (int x = 0; x < width; x += 10) {
      float normalizedX = map(x, 0, width, -1, 1);
      float normalizedY = map(y, 0, height, -1, 1);

      float distToCenter = dist(normalizedX, normalizedY, 0, 0);

      float radius = .5 + .4 * sin(distToCenter * 10);
      float angle = atan2(normalizedY, normalizedX);
      float rotatedX = sin(angle + angularVelocity * averageAmplitude * time) * radius;
      float rotatedY = sin(angle + angularVelocity * averageAmplitude * time) * radius;

      float ellipseRadiusX = 0.3 + 0.2 * cos(time + distToCenter * 5);
      float ellipseRadiusY = 0.3 + 0.2 * sin(time + distToCenter * 5);
      float rotatedEllipseX = cos(angle) * ellipseRadiusX;
      float rotatedEllipseY = sin(angle) * ellipseRadiusY;

      float absDist = dist(normalizedX, normalizedY, rotatedX + rotatedEllipseX, rotatedY + rotatedEllipseY);

      float gradient = map(absDist, 0, radius, 0, 1);

      float strokeWeightValue = gradient * 3;
      strokeWeight(strokeWeightValue * (averageAmplitude * 12.));

      float alpha = map(averageAmplitude, 0, 1, 50, 255);
      float r = 255 * (sin(time + normalizedX * colorScaleR + phaseShift) * .5 + .5) * gradient * brightnessValue;
      float g = 255 * (cos(time + normalizedY * colorScaleG) * (.5 + averageAmplitude) + .5) * gradient * brightnessValue;
      float b = 255 * (sin(time + normalizedX * normalizedY * colorScaleB) * .5 + .5) * gradient * brightnessValue;

      stroke(r, g, b, alpha);
      point(x, y);
    }
  }
}

void stop() {
  if (in != null) {
    in.close();
  }
  minim.stop();
  super.stop();
}
