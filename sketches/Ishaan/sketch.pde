//This is Ishaan Garg's Code 
//It is a moving ball acording to the mouses position that disappers and appears upon clicking the mouse
//The background also changes according to the ball position aka the mouse position

int ballX, ballY; //introduce the integers as positions
color ballColour; //necessary for later changing the colour of the ball
float colourChange = 0; //The colour will change depending on this number
boolean ballVisible = true; //To make the ball disappear later

void setup() {
  size(600, 400); //size of the box 
  ballX = width / 2; //Ball size
  ballY = height / 2; //Ball size
}

void draw() {
  color bgColour = color(map(ballX, 0, width, 0, 255), map(ballY, 0, height, 0, 255), 150);
  background(bgColour); //in order to have a colour changing background dependant on the movement of the ball

  if (colourChange >= 0 && colourChange <= 254) { //an if statement that would allow us to have an everlasting cycle of the ball changing colours between 1 and 255
    colourChange += 1;
    ballColour = color(colourChange, 1, 255);
  } else {
    colourChange -= 255;
  }

  ballX = mouseX; //for the ball to follow the X position of the mouse
  ballY = mouseY; //for the ball to follow the Y position of the mouse

  if (ballVisible) { //to make the ball only fill when visible and transparent when its not
    fill(ballColour);
    ellipse(ballX, ballY, 50, 50);
  }
}

void mousePressed() {
  ballVisible = !ballVisible; // Tp change the visibility function of the ball and when mouse is pressed it shall change
}
