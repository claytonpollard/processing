float angle = 0;
float angleSpeed = 0.01;
float spiralSize = 1.0;

void setup() {
  size(600, 600);
}

void draw() {
  background(255);
  
  // Update angle and size based on mouse drag
  if (mousePressed) {
    float angleChange = map(mouseX - pmouseX, 0, width, 0, TWO_PI);
    angle += angleChange;
    
    float sizeChange = (mouseY - pmouseY) * 0.01;
    spiralSize += sizeChange;
  }

  translate(width / 2, height / 2);

  // Draw the growing and moving spiral
  drawSpiral();
  
  // Update angle for constant movement
  angle += angleSpeed;
}

void drawSpiral() {
  float x = 0;
  float y = 0;

  for (int i = 0; i < 100; i++) {
    float radius = i * spiralSize;
    float xPos = radius * cos(angle);
    float yPos = radius * sin(angle);

    stroke(0);
    noFill();
    ellipse(x, y, radius * 2, radius * 2);
    line(x, y, x + xPos, y + yPos);

    x += xPos;
    y += yPos;
  }
}
