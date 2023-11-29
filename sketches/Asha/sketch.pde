boolean bw11 = true;
boolean bw21 = true;
boolean bw12 = true;
boolean bw22 = true;
float a;
float b;
float c;
float d;
int X = mouseX/450;
int Y = mouseY/450;

void setup () {
  size ( 900, 900);
  colorMode(RGB);
  noStroke();
}

void draw ()
{

  rect(0, 0, 450, 450); //top right
  if (bw11  == true) { 
    fill (252 + c, 196 + d, 3);
  } else {
    fill (252 + a, 198 + b, 3);
  }
  
  rect(450, 0, 450, 450); //bottom left
  if (bw21  == true) {
    fill (242 + c, 186 + d, 3);
  } else {
    fill (252 + a, 169 + b, 3);
  }
  rect(0, 450, 450, 450); //bottom right
  if (bw12  == true) {
    fill (236 + c, 179 + d, 3);
  } else {
    fill (252 + a, 136 + b, 3);
  }
  
  rect(450, 450, 450, 450); //top left
  if (bw22  == true) {
    fill (252 + c, 186 + d, 3);
  } else {
    fill (252 + a, 219 + b, 3);
  }
}

void mouseClicked () {
 a = random(-30,30);
b= random(-30, 30);
round(a);
round(b);
c = random(-20,20);
d= random(-20, 20);
round(c);
round(d);
  if (( mouseX <= 450) && (mouseY >= 450)) {
   if (bw21 == true){
    bw21 = false;
  } else {
    bw21 = true; }
  }
    if (( mouseX >= 450) && (mouseY <= 450)) {
   if (bw11 == true){
    bw11 = false;
  } else {
    bw11 = true; }
  } 
  if (( mouseX <= 450) && (mouseY <= 450)) {
   if (bw22 == true){
    bw22 = false;
  } else {
    bw22 = true; }
  } 
  if (( mouseX >= 450) && (mouseY >= 450)) {
   if (bw12 == true){
    bw12 = false;
  } else {
    bw12 = true; }
  }
}
