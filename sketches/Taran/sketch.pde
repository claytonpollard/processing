float max_distance;  
void setup() {
  size(640, 360, P3D);
  noStroke();
}

void draw() {
  defineLights();
  background(0);
  int gridSize = 40;

  for (int x = 0; x <= width; x += 60) {
    for (int y = 0; y <= height; y += 60) {
      pushMatrix();
      translate(x, y);
      rotateY(map(mouseX, 0, width, 0, PI));
      rotateX(map(mouseY, 0, height, 0, PI));
      box(50);
      popMatrix();
    }
  }
    for (int x = gridSize; x <= width - gridSize; x += gridSize) {
     for (int y = gridSize; y <= height - gridSize; y += gridSize) {
       noStroke();
       fill(255);
       stroke(255, 100);
       line(x, y, mouseX, mouseY);
     }
  }
}


void defineLights() {
  // Magenta 
  pointLight(255, 0, 255,   
             200, -150, 0); 

  // Lime 
  directionalLight(50, 205, 50,
                   1, 0, 0);    

  // Light Blue 
  spotLight(173, 216, 230,  
            0, 40, 200,     
            0, -0.5, -0.5, 
            PI / 2, 8);     
}
