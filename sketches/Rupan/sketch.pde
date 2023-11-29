Bubble b;

void setup() {
  size(640,360);
  b = new Bubble();
}

void draw() {
  background(255);
  b.ascend();
  b.display();
  //b.top();
}

void mousePressed() {
  popMatrix();
}
