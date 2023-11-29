int p, ballSpeed;
boolean canBall;
int netSum;

ArrayList<dot> Dots;
ArrayList<ball> Balls;

void setup() {
  netSum = 0;
  p = 0;
  ballSpeed = 350;
  size(1000, 1000);
  
  canBall = true;
  Dots = new ArrayList<dot>();
  Balls = new ArrayList<ball>();
  colorMode(HSB);
}

void draw() {  
  background(0);
    strokeWeight(2);
  for(int k=0; k<Dots.size(); k++) {
    dot dotTemp1 = Dots.get(k);
   for(int j=0; j<Dots.size(); j++) {
     dot dotTemp2 = Dots.get(j);
       stroke((dotTemp1.col+dotTemp2.col)/2);
     line(dotTemp1.x, dotTemp1.y, dotTemp2.x, dotTemp2.y);
   }   
  }
  
  if (mousePressed) { circle(mouseX, mouseY, 10); }
  for(int i=0; i <Dots.size(); i++) {
    dot dotTemp = Dots.get(i);
    dotTemp.render();
  }
  
  if (Dots.size()>=2 && canBall==true) {
    Balls.add(new ball(ballSpeed, 15, 0, 1));
    canBall=false;
  }
  
   for(int i=0; i <Balls.size(); i++) {
    ball ballTemp = Balls.get(i);
    ballTemp.follow();
    
    
    
    if (ballTemp.dupe == true) {
      
      int dot2Temp = 0;
        dot2Temp=(int)(random(Dots.size())-1);
      if(dot2Temp==ballTemp.dotGet1) {
        if (ballTemp.dotGet1>=Dots.size()-1) {
          dot2Temp=0;
        }else{dot2Temp++;}
      }
      if(dot2Temp==ballTemp.dotGet2 && Dots.size()>2) {
        if(dot2Temp+1==ballTemp.dotGet1) {
            dot2Temp=dot2Temp+2;
            if(dot2Temp>=Dots.size()) {dot2Temp=0;}
          }else{dot2Temp++;}
        if (ballTemp.dotGet2==Dots.size()-1) {
          if(ballTemp.dotGet1==0){
            dot2Temp=1;
          }else{dot2Temp=0;}
        } 
      }
      Balls.add(new ball(ballSpeed, 15, ballTemp.dotGet1, dot2Temp));
    }
  }
}



void mouseReleased() {
  Dots.add(new dot(mouseX, mouseY, (color(random(255), 255, 255))));
}

void keyPressed() {
  while(Dots.size()>0) {
    Dots.remove(0);
  }
  while(Balls.size()>0) {
    Balls.remove(0);
  }
  canBall=true;
}

//CLASSES:

class ball {
  int x, y, speed, size, counter, dx, dy, dotGet1, dotGet2;
  boolean dupe;
  color col;
 
  ball(int speed, int size, int dotGet1, int dotGet2) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.size = size;
    this.dx = dx;  //the difference in the x values of the two points
    this.dy = dy;  //the difference in the y values of the two points
    this.dotGet1 = dotGet1;
    this.dotGet2 =dotGet2;
    this.col= col;
    this.dupe= dupe;
  }
  
  void follow() {
    noStroke();
    
    dot dotTemp1 = Dots.get(dotGet1);
    dot dotTemp2 = Dots.get(dotGet2);
    
    dx = dotTemp2.x-dotTemp1.x;
    dy = dotTemp2.y-dotTemp1.y;
    col = (dotTemp1.col+dotTemp2.col)/2;
    
    x = dotTemp1.x + counter*dx/speed;
    y = dotTemp1.y + counter*dy/speed;
    
    if (counter==speed) {
      dotGet1=dotGet2;
      dotGet2=(int)(random(Dots.size())-1);
      if(dotGet2==dotGet1) {
        if (dotGet1==Dots.size()-1) {
          dotGet2=0;
        }else{dotGet2++;}
      }
      if(dotGet2>=Dots.size()) {dotGet2=0;}
      counter = 0;
      dupe=true;
    }else{
      dupe=false;
    }

    fill(col);
    circle(x, y, size);
    counter++;
  }
  
}


class dot {
  int x, y;
  color col;
 
  dot(int x, int y, color col) {
    this.x = x;
    this.y = y;
    this.col= col;
  }
  
  void render() {
    noStroke();
    fill(col);
    circle(x, y, 10);
  }
  
}
