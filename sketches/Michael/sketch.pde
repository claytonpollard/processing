/*  This is me learning fractal trees. Not the best optimisation in terms of 
    performance. Some note taking with commented lines.
*/

final int NUM_TREES = 10;
final float BRANCH_LENGTH_SCALE = 0.3;
final float BRANCH_LENGTH_THRESHOLD = 0.6;

float branchLength;
float branchAngle;
float hueValue;
float brightnessValue;


void mousePressed() {
  
  background(255);
  
  
}

void setup() {
  // Set up the canvas
  size(800, 800);
  colorMode(HSB);
  background(255);
  frameRate(120);
}

void draw() {
  // Draw multiple trees in a circular arrangement
  for (float rotation = 0; rotation < TWO_PI; rotation += PI / NUM_TREES * 2) {
    drawTree(rotation);
  }
}

void drawTree(float rotation) {
  // Update color values based on sine functions
  hueValue = (sin(frameCount / 200.0) + 1) * 255;
  brightnessValue = (abs(tan(frameCount / 600.0)) + 1) * 255;

  // Set stroke properties for the tree branches
  strokeWeight(0.1);
  branchLength = height / 512 + (sin(frameCount / 150.0) + 1) * (height / 7);
  branchAngle = PI / 12 + sin(frameCount / 60.0);

  // Draw the tree at the specified rotation
  pushMatrix(); // Save the current transformation state
  stroke(hueValue % 255, 255, brightnessValue);
  translate(width / 2, height / 2);
  rotate(rotation);
  drawBranch(branchLength, branchAngle);
  popMatrix(); // Restore the previous transformation state
}

void drawBranch(float length, float angle) {
  // Draw a branch and recursively draw smaller branches
  line(0, 0, 0, -length);
  translate(0, -length);

  pushMatrix(); // Save the current transformation state
  rotate(angle);
  if (length > BRANCH_LENGTH_THRESHOLD) {
    drawBranch(length * BRANCH_LENGTH_SCALE, angle);
  }
  popMatrix(); // Restore the previous transformation state

  rotate(-angle);
  if (length > BRANCH_LENGTH_THRESHOLD) {
    drawBranch(length * (1 - BRANCH_LENGTH_SCALE), angle);
  }
}
