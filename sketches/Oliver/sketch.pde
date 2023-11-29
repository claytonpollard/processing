ArrayList<Fuse> fuses;
ArrayList<Particle> particles;
ArrayList<Explosion> explosions;
int startX, startY;

void setup() {
  frameRate(60); //Set a specific framerate so that game does not run to fast
  size(1920,1080);
  
  fuses      = new ArrayList<Fuse>();      //Create an empty ArrayList of objects
  particles  = new ArrayList<Particle>();  //Create an empty ArrayList of objects
  explosions = new ArrayList<Explosion>(); //Create an empty ArrayList of objects
  
  colorMode(HSB);
}

void draw() {
  background(0); //Set the background to black
  
  //Setting variables for and drawing new fuses
  if (mousePressed == true) {
    stroke(255);
    strokeWeight(height / 200);
    line(startX, startY, mouseX, mouseY);
  } else {
    startX = mouseX;
    startY = mouseY;
  }
  
  //Update fuses
  for (int i = 0; i < fuses.size(); i++) {
    Fuse fuse = fuses.get(i);
    fuse.step();
    if (fuse.done() == true) { fuses.remove(i); }
  }
  
  //Update fuse particles
  for (int i = 0; i < particles.size(); i++) {
    Particle particle = particles.get(i);
    particle.step();
    if (particle.done() == true) { particles.remove(i); }
  }
  
  //Update explosions particles
  for (int i = 0; i < explosions.size(); i++) {
    Explosion explosion = explosions.get(i);
    explosion.step();
    if (explosion.done() == true) { explosions.remove(i); }
  }
}

//Create a new fuse when the mouse is released
void mouseReleased() {
  fuses.add(new Fuse(color(random(0, 255), 255, 255), startX, startY, mouseX, mouseY));
}

class Explosion {
  int x, y, time;
  color col;
  PVector movement;
  
  //Explosions constructor
  Explosion(color col, int maxTime, int x, int y) {
    this.x = x;
    this.y = y;
    this.time = maxTime * 2;
    this.col = col;
    this.movement = new PVector(random(-1, 1), random(-1, 1));
    movement.normalize();
    movement.x *= random(0, 5);
    movement.y *= random(0, 5);
  }
  
  //Step once through simulating the explosion particles
  void step() {
    //Simulate the explosion particle
    time -= 1;
    x += movement.x;
    y += movement.y;
    movement.x += 1.2 * (noise(random(1000)) - 0.455);
    movement.y += 1.2 * (noise(random(1000)) - 0.455);
    
    //Draw the explosion particle
    noStroke();
    fill(col, map(time, 200, 0, 255, 0) + 150 * (noise(random(1000)) - 0.5));
    circle(x + noise(time) - 0.5, y + noise(time) - 0.5, height / 50);
  }
  
  //Delete the particle if it's dissapeared (so that it doesn't lag)
  boolean done() {
    if (time <= 0) {
      return true;
    } else {
      return false;
    }
  }
   
}

class Fuse {
  int time, maxTime;
  int sx, sy, ex, ey;
  color col;
  
  //Fuses constructor
  Fuse(color col, int sx, int sy, int ex, int ey) {
    this.sx = sx;
    this.sy = sy;
    this.ex = ex;
    this.ey = ey;
    
    this.col = col;
    
    maxTime = 100 * ceil(sqrt(sq(ex - sx) + sq(ey - sy))) / height;
    time = maxTime;
  }
  
  //Step once through simulating the fuses
  void step() {
    //Simulate the fuse
    time -= 1;
    
    //Draw the fuse
    stroke(255);
    strokeWeight(height / 200);
    line(sx + (ex - sx) * map(time, maxTime, 0, 0, 1), sy + (ey - sy) * map(time, maxTime, 0, 0, 1), ex , ey);
    noStroke();
    fill(col);
    circle(ex, ey, height/ 50);
    
    //Add particles at the end of the fuse
    particles.add(new Particle(col, sx + (ex - sx) * map(time      , maxTime, 0, 0, 1), sy + (ey - sy) * map(time      , maxTime, 0, 0, 1)));
    particles.add(new Particle(col, sx + (ex - sx) * map(time + 0.3, maxTime, 0, 0, 1), sy + (ey - sy) * map(time + 0.3, maxTime, 0, 0, 1)));
    particles.add(new Particle(col, sx + (ex - sx) * map(time - 0.3, maxTime, 0, 0, 1), sy + (ey - sy) * map(time - 0.3, maxTime, 0, 0, 1)));
  }
  
  //Delete the particle if it's dissapeared (so that it doesn't lag)
  boolean done() {
    if (time <= 0) {
      //Create new explosion at the end of fuse
      for (int i = 0; i < 500; i++) {
        explosions.add(new Explosion(col, maxTime, ex, ey));
      }
      return true;
    } else {
      return false;
    }
  }
   
}

class Particle {
  int time;
  float x, y;
  color col;
  
  //Particles constructor
  Particle(color col, float x, float y) {
    this.time = 10;
    this.x = x;
    this.y = y;
    this.col = col;
  }
  
  //Step once through simulating the fuses particles
  void step() {
    //Simulate the fuse particle
    time -= 1;
    
    //Draw the fuse particle
    noStroke();
    fill(col, time * 127 / 8);
    circle(x + (noise(x)-0.5)*10, y + (noise(y)-0.5)*10, height/80);
  }
  
  //Delete the particle if it's dissapeared (so that it doesn't lag)
  boolean done() {
    if (time <= 0) {
      return true;
    } else {
      return false;
    }
  }
   
}
