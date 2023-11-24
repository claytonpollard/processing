Eye e1, e2;

void setup() {
 
  size(1000,1000);
  noStroke();
  e1 = new Eye( 435,  300, 100);
  e2 = new Eye( 565, 300,  100);  

}

void draw() {
  background(242, 231, 220);
  
  fill(92, 84, 77);
  ellipse(500,325, 325, 260 );
    ellipse(370,375, 100, 150 );
    ellipse(630,375, 100, 150 );
      rect(370, 300, 260,150);
        triangle(460, 220, 340, 140, 340 , 300);
        triangle(540, 220, 660, 140, 660 , 300);
    ellipse(500, 600, 300, 400);
      ellipse(400, 655, 220, 260);
      ellipse(600, 655, 220, 260);
        ellipse(350, 750, 200, 100);
        ellipse(650, 750, 200, 100);
        


  fill(59, 57, 54);
  triangle(465, 350, 535, 350, 500, 390);
    arc(470, 390, 60, 70, 0, PI / 2.0); // lower quarter circle
    arc(530, 390, 60, 70, HALF_PI, PI);
     

fill(92, 84, 77);
  arc(466, 384, 60, 70, 0, PI / 2.0); // lower quarter circle
  arc(534, 384, 60, 70, HALF_PI, PI);
   
    
fill(156, 151, 143);
   ellipse(500, 650, 250, 275);

fill(92, 84, 77);
    ellipse(430, 600, 75, 250);
       ellipse(430, 675, 75, 100);
    ellipse(570, 600, 75, 250);
       ellipse(570, 675, 75, 100);

fill(232, 191, 174);
  ellipse(390, 380, 75, 50);
  ellipse(610, 380, 75, 50);
  
  e1.update(mouseX, mouseY);
  e2.update(mouseX, mouseY);


  e1.display();
  e2.display();

  

}

class Eye {
  int x, y;
  int size;
  float angle = 0.0;
  
  Eye(int tx, int ty, int ts) {
    x = tx;
    y = ty;
    size = ts;
 }

  void update(int mx, int my) {
    angle = atan2(my-y, mx-x);
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    fill(221, 245, 169);
    ellipse(0, 0, size, size);
    rotate(angle);
    fill(0);
    ellipse(size/4, 0, size/2, size/2);
    popMatrix();
  }
}
