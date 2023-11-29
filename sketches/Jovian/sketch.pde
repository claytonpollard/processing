

void setup() {
  size(640, 360); 
  noStroke();
  rectMode(CENTER);
}

void draw() {
   if (mousePressed) {
    stroke(200);
    fill(105, 204);
  } else {
    stroke(0);
    fill(255, 204);
  }
  background(51); 
  rect(mouseX, height/2, mouseY/2+10, mouseY/2+10);
  int inverseX = width-mouseX;
  int invers
;}
