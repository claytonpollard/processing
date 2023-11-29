float CCR = 2;
float CCG = 9;
float CCB = 3;
float R = 0;
float G = 0;
float B = 0;

void setup() {
  size(1000, 1000);
  smooth();
  noStroke();
  background(0);
}

void draw() {
  
  noStroke();
  fill( 0, 20);  // fill with black, low opacity; builds up over old ellipses
  rect(0, 0, width, height);

  fill(255,255);
  ellipse(mouseX,mouseY, 80 ,80);
  
R = R + CCR;
G = G + CCG;
B = B + CCB;
 
  if (R > 254 || R< 1) {
   CCR = CCR* -1;
  }
 
  if (G > 254 || G < 1) {
   CCG = CCG* -1;
  }
 
  if (B > 254 || B < 1) {
   CCB= CCB* -1;
  }
    if (mousePressed) {
    fill(R, G, B);
  } else {
    fill(255);
  }
  ellipse(mouseX, mouseY, 80, 80);
  
}
