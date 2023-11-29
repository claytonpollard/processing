float prevX, prevY;

void setup() {
  size(600, 400);
  noStroke();
  background(0);
}

void draw() {
  // Add a slight fade effect to create a trail
  fill(0, 10);
  rect(0, 0, width, height);

  // form a pulsating colourchanging circle at the mouse
  float pulse = sin(frameCount * 0.05) * 30 + 50; // Pulsating effect
  float r = cos(frameCount * 0.02) * 127 + 128;
  float g = sin(frameCount * 0.03) * 127 + 128;
  float b = cos(frameCount * 0.04) * 127 + 128;
  fill(r, g, b);
  
  float diameter = dist(mouseX, mouseY, prevX, prevY) + pulse;
  if (diameter > 10) {
    ellipse(mouseX, mouseY, diameter, diameter);
  }
  
  
  // Update previous mouse position
  prevX = mouseX;
  prevY = mouseY;
}
