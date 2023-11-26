
int paddleWidth = 8;
int paddleHeight = 80;
float paddleSpeed = 4;
float paddle1Y, paddle2Y;
float paddle1Speed = 0;
float paddle2Speed = 0;
float ballSize = 20;
float ballX, ballY;
float ballSpeedX = 5;
float ballSpeedY = 3;
void setup() {
  size(600, 400);
  paddle1Y = height / 5 - paddleHeight / 5;
  paddle2Y = height / 5 - paddleHeight / 5;
  ballX = width / 6;
  ballY = height / 6;
}
void draw() {
  background(#0000FF);
  fill(255);
  rect(0, paddle1Y, paddleWidth, paddleHeight);
  rect(width - paddleWidth, paddle2Y, paddleWidth, paddleHeight);
  ellipse(ballX, ballY, ballSize, ballSize);
  
  movePaddles();
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  
  if (ballY - ballSize / 2 < 0 || ballY + ballSize / 2 > height) {
    ballSpeedY *= -1;
  }
  if (ballX - ballSize / 2 < paddleWidth && ballY > paddle1Y && ballY < paddle1Y + paddleHeight) {
    ballSpeedX *= -1;
  }
  if (ballX + ballSize / 2 > width - paddleWidth && ballY > paddle2Y && ballY < paddle2Y + paddleHeight) {
    ballSpeedX *= -1;
  }
  if (ballX < 0 || ballX > width) {
    // Reset ball position
    ballX = width / 2;
    ballY = height / 2;
  }
}
void movePaddles() {
 
  if (keyPressed) {
    if (key == 'w' && paddle1Y > 0) {
      paddle1Y -= paddleSpeed;
    }
    if (key == 's' && paddle1Y + paddleHeight < height) {
      paddle1Y += paddleSpeed;
    }
  }

  if (keyPressed) {
    if (keyCode == UP && paddle2Y > 0) {
      paddle2Y -= paddleSpeed;
    }
    if (keyCode == DOWN && paddle2Y + paddleHeight < height) {
      paddle2Y += paddleSpeed;
    }
  }
}
