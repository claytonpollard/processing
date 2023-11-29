float R, G, B;
float CR = 1.2;
float CG = 1.4;
float CB = 1.6;
void setup() {
  size(640, 360, P3D);
  noStroke();
}
void draw() {
  background(0);
  translate(width/2, height/2, 0);
  rotateX(PI/3 + mouseY/float(height) * PI);
  rotateY(PI/3 + mouseX/float(height) * PI);
  R = R + CR;
  G = G + CG;
  B = B + CB;
  if (R > 254 || R < 1) {
    CR = CR * -1;
  }
  if (G > 254 || G < 1) {
    CG = CG * -1;
  }
  if (B > 254 || B < 1) {
    CB = CB * -1;
  }
  fill(R, G, B);
  directionalLight(R, G, B, -0.5, -0.5, -0.5);
  if (mousePressed == true) {
    translate(0, 0, 50);
    sphere(20);
    translate(0, 0, -50);
    sphere(20);
    translate(0, 50, 50);
    sphere(20);
    translate(0, 0, -50);
    sphere(20);
  } else {
    sphere(120);
  }
}
