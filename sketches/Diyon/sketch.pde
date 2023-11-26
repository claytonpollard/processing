void setup() {
  size(1920,1080);
  background(125);
}

void draw() {
   float a = random(0,255);
  float b = random(0,255);
  float c = random(0,255);
  
  
  
  if (mousePressed) {
    background(125);
  } 
  
  
  else {
    stroke(0);
    fill(a, b, c);
    rect(mouseX, mouseY, 80, 80);
  }
 
  
  
}
