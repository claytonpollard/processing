float CCR = 6;
float CCG = 3;
float CCB = 3;
int rectColor[][] = new int[7][3];

void setup() {
  size(400, 400);
  colorMode(RGB, 255, 255, 255);
  for (int i = 0; i < 7; i++) {
  rectColor[i][0] = int(random(255));
  rectColor[i][1] = int(random(255));
  rectColor[i][2] = int(random(255));
  }
}

void draw() {
  background(100);

  for (int i = 0; i < 7; i++) {
  fill(rectColor[i][0], rectColor[i][1], rectColor[i][2]);
  rect(50 + 25 * i, 50 + 25 * i, 300 - 50 * i, 300 - 50 * i);
  }
}

void mouseMoved() {
  for (int i = 6; i >= 0; i--) {
  if (mouseX >= 50 + 25 * i && mouseX <= 350 - 25 * i && mouseY >= 50 + 25 * i && mouseY <= 350 - 25 * i) {
    rectColor[i][0] = (int)((rectColor[i][0] + CCR + 256) % 256);
    rectColor[i][1] = (int)((rectColor[i][1] + CCG + 256) % 256);
    rectColor[i][2] = (int)((rectColor[i][2] + CCB + 256) % 256);
    break;
  }
  }
}


