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
