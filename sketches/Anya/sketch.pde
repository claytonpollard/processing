//Hello, I made a Snake Game.
//It is mainly based on these:
//https://www.youtube.com/watch?v=JGW5ecDOjjk&ab_channel=KTByte
//https://openprocessing.org/sketch/50988/#

//Arrays to store the snake coordinates.
ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
int w = 16, h = 16, bs = 25; //Grid dimensions (width, height, block size).
int dir = 2; //Snake direction.
int applex, appley; //Apple coordinates.
int[] dx = {0,0,1,-1}, dy = {1,-1,0,0}; //Direction vectors.
boolean stopgame = false; //Control game state.
int screenstate = 0; //Variable for the game screen state.
int score = 0; //Player score.


void setup() {
   size(400, 400);
   setsnake(); //Spawn the snake.
   setapple(); //Spawn the apple.
   checkapple(); //Check the apple placement.
}

void setsnake() {
   x.add(5); //Initial snake x.
   y.add(5); //Initial snake y.

}

void setapple() {
   applex = floor(random(w)); //Randomise apple coordinates.
   appley = floor(random(h));     
}

void checkapple(){
  for(int i = 1; i < x.size(); i++) //For the snake body.
     if(applex == x.get(i) &&  appley == y.get(i)) { //If the apple is on the body.
       setapple(); //Respawn the apple.
     }
}

void draw() { //Here is the main game loop.
  if (screenstate == 0) {
    startscreen();
  } else if (screenstate == 1) {
    gamescreen();
  } else if (screenstate == 2) {
    endscreen();
  }

}

void startscreen() {
  background(231, 248, 251);
  textAlign(CENTER);
  textSize(20);
  text("Snake Game. Click to start.", height/2, width/2);
  fill(83, 174, 195);
}

void gamescreen() {
  background(231, 248, 251);
  stroke(83, 174, 195);
  drawgrid(); //Draw grid lines.
//Draw the snake.
for(int i = 0 ; i < x.size(); i++) { //i(iteration) counts the loop.
  fill(83, 174, 195);
  rect(x.get(i)*bs, y.get(i)*bs, bs, bs);
}

if(!stopgame) { //If the game is still running.
  fill(225, 131, 70);
  rect(applex*bs, appley*bs, bs, bs); //Draw the apple.

  if ((frameCount % 8)==0) //This check is used to control the frame rate.
  {
    move(); //Move the snake head.
    show(); //Draw the snake tail and apple positions.
    checkdead(); //Check for collisions.
    }
  } else {
    screenstate = 2; //Switch to the end screen if the game is over.
  }
}

void endscreen() {
  stopgame = true;
  fill(215, 240, 245);
  rect(100,150,200,100);
  fill(225, 131, 70);
  textSize(20);
  text("Game over",width/2,180);
  text("Score:  "+str(score)+" apples.",width/2,205);
  text("Space to restart.",width/2,230);
  
  if(keyPressed && key == ' ') {
    resetgame(); //Restart when the spacebar is pressed.
  }
}

void drawgrid(){
  for(int i = 0 ; i < w; i++) line(i*bs, 0, i*bs, height); //Vertical lines.
  for(int i = 0 ; i < h; i++) line(0, i*bs, width, i*bs); //Horizontal lines.
}

void mousePressed() { //Mouse click to start the game.
  if (screenstate==0) {
    screenstate = 1;
  }
}

void resetgame() {
  x.clear(); //Clear snake coordinates.
  y.clear();
  setsnake();
  setapple();
  stopgame=false; //Reset game state to play.
  score = 0;
  screenstate = 1;
  dir = 2; //Reset snake direction.
}

void move() {
  x.add(0,x.get(0) + dx[dir]); //Update snake x.
  y.add(0,y.get(0) + dy[dir]); //Update snake y.
}

void show() { 
  if(x.get(0)==applex && y.get(0)==appley) { //Check if snake xy and apple xy match.
    score = (score + 1); //Increase the score.
    setapple();
    checkapple();
  } else {
  x.remove(x.size()-1); //Otherwise keep removing last segment of the snake.
  y.remove(y.size()-1);
  }
}
  
void checkdead() {
  if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h) //Snake hitting wall?
    screenstate = 2; //Game over.
for(int i = 1; i < x.size(); i++) //For the snake body.
  if(x.get(0) == x.get(i) &&  y.get(0) == y.get(i)) //Snake hitting itself?
    screenstate = 2; //Game over.
}

void keyPressed() //This function is activated whenever a key is pressed.
{
 int newdir = -1; //Declares new variable: new direction.

  //Updates new direction based on player input.
  if (keyCode == DOWN || key == 's' || key == 'S') {
    newdir = 0;
  } else if (keyCode == UP || key == 'w' || key == 'W') {
    newdir = 1;
  } else if (keyCode == RIGHT || key == 'd' || key == 'D') {
    newdir = 2;
  } else if (keyCode == LEFT || key == 'a' || key == 'A') {
    newdir = 3;
  }

  // Change direction if the newdir is no longer -1.
  if (newdir != -1 && (x.size() <= 1 || !(x.get(1) == x.get(0) + dx[newdir] && y.get(1) == y.get(0) + dy[newdir]))) {
    dir = newdir;
  }
}
