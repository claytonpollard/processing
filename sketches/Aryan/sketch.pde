float x;

void setup() {
 size(800,600);
 x = 400;
}
void draw() {
  background(random(255), random(255), (255));
  noStroke();
  x = x + 30;
  
  if(x > width) {
    x = 0;
  }
  
  fill(random(47), random(53), 59);
  ellipse(x, 100, 100, 100);
  ellipse(x, 400, 100, 100);
  ellipse(x, 500, 100, 100);
}
