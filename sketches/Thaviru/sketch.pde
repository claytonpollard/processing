/*
A bouncing ball by Thaviru Gunawardena

Invert the colours by clicking
*/

float x = 350;
float y = 200;
float Speedx = -5;
float Speedy = -5;
float ColourChangeR = 1;
float ColourChangeG = 2;
float ColourChangeB =3;
float ColourR = 0;
float ColourG = 0;
float ColourB = 0;

void setup() {
  size(700, 400);
  noStroke();
}

void draw() {
    
  x = x + Speedx;
  y = y + Speedy;
  ColourR = ColourR + ColourChangeR;
  ColourG = ColourG + ColourChangeG;
  ColourB = ColourB + ColourChangeB;
  
  if (ColourR > 254 || ColourR < 1) {
   ColourChangeR = ColourChangeR * -1; 
  }
  
  if (ColourG > 254 || ColourG < 1) {
   ColourChangeG = ColourChangeG * -1;
  }
  
  if (ColourB > 254 || ColourB < 1) {
   ColourChangeB = ColourChangeB * -1;
  }

  if (x > width-50 || x < 50) {
    Speedx = Speedx * -1;
  }

  if (y > height-50 || y < 50) {
    Speedy = Speedy * -1;
  }

  if (mousePressed) {
    background(ColourR, ColourG, ColourB);
    ellipse(x, y, 100, 100);
    fill(255, 255, 255);

    
  } else {
    background(255,255,255);
    ellipse(x, y, 100, 100);
    fill(ColourR, ColourG, ColourB);
    
  }
}
