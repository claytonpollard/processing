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
