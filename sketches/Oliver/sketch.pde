ArrayList<Fuse> fuses;
ArrayList<Particle> particles;
ArrayList<Explosion> explosions;
int startX, startY;

void setup() {
  frameRate(60); //Set a specific framerate so that game does not run to fast
  fullScreen(); //Set size of canvas to the size of the screen
  
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
