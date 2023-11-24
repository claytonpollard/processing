void setup() {
  size(640, 360);
  colorMode(HSB, 360, 100, 100); // Set color mode to HSB for easier rainbow effect
  background(102);
}

void draw() {
  variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
}

void variableEllipse(int x, int y, int px, int py) {
  float speed = abs(x - px) + abs(y - py);
  float hue = map(speed, 0, width, 0, 360); // Map speed to the hue range (rainbow colors)
  fill(hue, 100, 100);
  noStroke();
  ellipse(x, y, speed, speed);
}
