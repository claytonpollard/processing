class Explosion {
  int x, y, time;
  color col;
  PVector movement;
  
  //Explosions constructor
  Explosion(color col, int maxTime, int x, int y) {
    this.x = x;
    this.y = y;
    this.time = maxTime;
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
