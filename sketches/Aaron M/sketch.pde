int num = 60;
float mx[] = new float[num];
float my[] = new float[num];
int barWidth = 20;
int lastBar = -1;

void setup() {
  size(1000, 600);
  noStroke();
  fill(255, 153);
}

void draw() {
  background(51);
  int whichBar = mouseX / barWidth;
  int barX = whichBar * barWidth;
  fill(barX, 100, mouseY);
  lastBar = whichBar;
  int which = frameCount % num;
  mx[which] = mouseX;
  my[which] = mouseY;

  for (int i = 0; i < num; i++) {
    // which+1 is the smallest (the oldest in the array)
    int index = (which+1 + i) % num;
    ellipse(mx[index], my[index], i, i);
  }
}
