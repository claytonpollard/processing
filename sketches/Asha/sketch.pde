boolean bw11 = true;
boolean bw21 = true;
boolean bw12 = true;
boolean bw22 = true;
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
    fill (252, 186, 3);
  } else {
    fill (252, 198, 3);
  }
  
  rect(450, 0, 450, 450); //bottom left
  if (bw21  == true) {
    fill (252, 186, 3);
  } else {
    fill (252, 169, 3);
  }
  rect(0, 450, 450, 450); //bottom right
  if (bw12  == true) {
    fill (252, 186, 3);
  } else {
    fill (252, 136, 3);
  }
  
  rect(450, 450, 450, 450); //top left
  if (bw22  == true) {
    fill (252, 186, 3);
  } else {
    fill (252, 219, 3);
  }
}

void mouseClicked () {
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
