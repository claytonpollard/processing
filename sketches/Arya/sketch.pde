void setup (){
  size(500,500);
   noLoop();
   frameRate(60);
   background(0);
  }

void draw (){
  color c = color(random(0, 255),random(0, 255),random(0, 255));
for (int i = 0; i < 500; i++) {
  float r = random(500);
  stroke(c);
  line(500+r, 125-r, i+r, 100*r);
}
}

void mousePressed() {
  loop();
}

void mouseReleased() {
  noLoop();
}
