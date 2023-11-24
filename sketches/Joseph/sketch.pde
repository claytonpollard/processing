float theta;   

void setup() {
  size(640, 360);
}

void draw() {
  background(150);
  frameRate(144);
  
  for (int i = 0; i < 2; i++) {
    stroke(0);
    float a = (mouseX / (float) width) * 135f;
    theta = radians(a);
    translate(width * (i + 1)/4,height * (1 - i));
    line(0,0,0,-120);
    translate(0,-120);
    branch(120);
  }

}

void branch(float h) {
  h *= 0.66;
 
  if (h > 2) {
    pushMatrix();    
    rotate(theta);   
    line(0, 0, 0, -h);  
    translate(0, -h); 
    branch(h);      
    popMatrix();     
    
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}
