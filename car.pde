import ddf.minim.*;
Minim minim;
AudioPlayer sound, gameover, fanfare, levelup;

Walker knight;
Star myStar1 = new Star(), myStar2 = new Star(), myStar3 = new Star();
Car[] myCar1 = new Car[5];
Car2[] myCar2 = new Car2[5];
Truck[] myTruck1 = new Truck[5];
Race[] myRace1 = new Race[5];
Train[] myTrain1 = new Train[5];
Lives lives3, lives2, lives1;
PShape car, truck, car2, race, train, train1, train2, train3, house, livesVector;
PImage img, santa, santa2, coolface, frameImage;
PFont mono, timer, bono;
float speedlevel, left, right, down, up;
boolean collision, pause, continued, displayLevelUp;
int lives, level, begin, duration, time, offset, last, delay, levelTimer;

float[] xBounds = new float[2], yBounds = new float[2];
float [] xCar = new float[2], yCar = new float[2];
float [] xCarTop = new float[2], yCarTop = new float[2];
float [] xCarLight = new float[2], yCarLight = new float[2];
float [] xTruck = new float[2], yTruck = new float[2];
float [] xCar2 = new float[2], yCar2 = new float[2];
float [] xRace = new float[2], yRace = new float[2];
float [] xTrain = new float[2], yTrain = new float[2];
float [] xCaboose = new float[2], yCaboose = new float[2];


//Pause 
int rectX, rectY, rectX2, rectY2;      
int circleX, circleY, circleX2, circleY2;  
int rectSize1 = 150;     
int rectSize2 = 70; 
int circleSize = 93;   
int rectSize12 = 150;     
int rectSize22 = 70; 
int circleSize2 = 93; 
color rectColor, circleColor, rectColor2, circleColor2 ;
color rectHighlight, circleHighlight, rectHighlight2, circleHighlight2;
boolean rectOver = false;
boolean circleOver = false;
boolean rectOver2 = false;
boolean circleOver2 = false;

void setup() {
  size(840, 840);
  minim = new Minim (this);
  sound = minim.loadFile("SuperMarioBros.mp3");
  gameover = minim.loadFile("gameover.mp3");
  fanfare = minim.loadFile("fanfare.mp3"); 
  levelup = minim.loadFile("levelup.mp3"); 
  mono = createFont("Palatino-Bold", 64);
  bono = createFont("Palatino-Bold", 20);
  timer = createFont("Arial Bold", 24);
  begin = millis();
  time = duration = 30;
  santa = loadImage("santa.png");
  santa2 = loadImage ("santa_win.png"); 
  coolface = loadImage("coolface.png"); 
  house = loadShape("shape.svg");
  car = loadShape("transport.svg");
  truck = loadShape("tool.svg");
  car2 = loadShape("car.svg");
  race = loadShape("race.svg");
  train = loadShape("train.svg");
  train1 = loadShape("train1.svg");
  train2 = loadShape("train2.svg");
  train3 = loadShape("train3.svg");
  
  knight = new Walker();
  speedlevel = 0;
  delay = 1000;
  pause = false; 
  continued = false;
  displayLevelUp = false;
  left = 0; 
  right = 0;
  down = 0; 
  up = 0;
  level = 1;
  lives = 3;
  livesVector = loadShape ("heart.svg");
  livesVector.scale (0.06);
  lives3 = new Lives (90, 10);
  lives2 = new Lives (50, 10);
  lives1 = new Lives (10, 10);
  
  rectColor = color(32, 228, 10);
  rectHighlight = color(45, 193, 29);
  circleColor = color(242,20, 20);
  circleHighlight = color(190, 21, 21);
  circleX = 540;
  circleY = height/2;
  rectX = 260;
  rectY = height/2-rectSize2/2;
  ellipseMode(CENTER);
  
  rectColor2 = color(10, 105, 228);
  rectHighlight2 = color(10, 84, 180);
  circleColor2 = color(242,20, 20);
  circleHighlight2 = color(190, 21, 21);
  circleX2 = 540;
  circleY2 = 535;
  rectX2 = 260;
  rectY2 = 500;
  ellipseMode(CENTER);
  
  
  
  
  
  
  scaleShapes();
  createVehicles();
}
 
void draw() {
  if (lives > 0 && pause == false && level < 4 && displayLevelUp == false) {
    sound.play();
    //background(255);
    drawRoad();
    //timer bar
    if (time > 0)  {
      time = duration - (millis() - begin)/1000;
      if(continued) {
      time = offset - (millis() - begin)/1000;
      } 
    } else {
      updateLives();
    }
    textFont(timer);
    float s1 = map(time, 0, 60, 0, 200);
    fill(255, 120, 134);
    rect(687, 9, s1, 24); 
    text(time, 650, 30);
    knight.display();
    for (int i = 0; i < 5; i++) {
      myCar2[i].display();
      checkCollision(xCar2, yCar2);
      myCar1[i].display();
      checkCollision(xCar, yCar);
      checkCollision(xCarTop, yCarTop);
      checkCollision(xCarLight, yCarLight);
      myTruck1[i].display();
      checkCollision(xTruck, yTruck);
      myRace1[i].display();
      checkCollision(xRace, yRace);
    }
    for (int i = 0; i < 2; i++) {
      myTrain1[i].display();
      checkCollision(xTrain, yTrain);
      checkCollision(xCaboose, yCaboose);
    }
    displayStars(); 
    displayHearts();
    levelUp();
  } else if (pause == true ) {
    pauseScreen();
    begin = millis();
    continued = true;
    offset = time;
    //sound.play();
  } else if (displayLevelUp == true) {
    levelUpScreen();
    begin = millis();
    if (millis() >= levelTimer) {
      displayLevelUp = false;
    }
  } else if (lives == 0 && pause == false && level < 4 && displayLevelUp == false) {
    GameOver();
  } else if (level > 3 && pause == false && displayLevelUp == false) {
    YouWin();
  }
}

void createVehicles() {
  int x = 0, y = 130;
  int xt = 840, yt = 240;
  int xr = 700, yr = 360;
  int xc = 840, yc = 480;
  int xtr = 0, ytr = 600;
  for (int i = 0; i < 5; i++) {
    myCar1[i] = new Car(x, y, 1 + speedlevel);
    x+= 250;
    myTruck1[i] = new Truck(xt, yt, 1 + speedlevel);
    xt-= 250;
    myRace1[i] = new Race(xr, yr, 2 + speedlevel);
    xr-= 300;
    myCar2[i] = new Car2(xc, yc, 1 + speedlevel);
    xc-= 250;
  }
  for (int i = 0; i < 2; i++) {
    myTrain1[i] = new Train(xtr, ytr, 0.5 + speedlevel);
    xtr-= 700;
  }
}

// Our function to return a new smaller crop from the spritesheet.
PImage getSubImage(PImage image, int row, int column, int frameWidth, int frameHeight)
{
  return image.get(column * frameWidth, row * frameHeight, frameWidth, frameHeight);
}

void checkCollision (float[] x, float[] y) {
  if ((((xBounds[0] >= x[0] && xBounds[0] <= x[1]) || (xBounds[1] >= x[0] && xBounds[1] <= x[1])) && 
      ((yBounds[0] >= y[0] && yBounds[0] <= y[1]) || (yBounds[1] >= y[0] && yBounds[1] <= y[1]))) ||   
      (((xBounds[0] >= x[0] && xBounds[0] <= x[1]) || (xBounds[1] >= x[0] && xBounds[1] <= x[1])) &&  
      ((yBounds[0] <= y[0] && yBounds[0] <= y[1]) && (yBounds[1] >= y[0] && yBounds[1] >= y[1])))) {
        updateLives();
      }
}

void boundsCheck() {
  if (xBounds[0] + left + right < 0 || xBounds[1] + left + right > width ||
     yBounds[0] + up + down < 120 && xBounds[0] + left + right < 370 || 
     yBounds[0] + up + down < 120 && xBounds[1] + left + right > 470) {
    knight.velocity.x = 0;
  } else {
    knight.velocity.x = knight.speed * (left + right);
  }
  if (yBounds[0] + up + down < 120 && xBounds[0] + left + right < 370 || 
   yBounds[0] + up + down < 120 && xBounds[1] + left + right > 470 
   || yBounds[1] + up + down > height ) {
    knight.velocity.y = 0;
  } else {
    knight.velocity.y = knight.speed * (up + down);
  }
}

void updateLives() {
  lives--;
  time = 30;
  begin = millis();
  offset = time;
  if (lives > 0) {
   knight.position.x = 420;
   knight.position.y = 780;
  }
}

void displayHearts() {
  if (lives >= 3) {
    lives3.display(); 
  }
  if (lives >= 2) {
    lives2.display(); 
  }
  if (lives >= 1) {
    lives1.display(); 
  }
}

void displayStars(){
  if (level >= 1){
    fill(#FDF10B);
    myStar1.star(391, 47, -0.6);
  }
  if (level >= 2){
    fill(#0E45D0);
    myStar2.star(421, 37, 0);
  }
  if (level >= 3){
    fill(#A90909);
    myStar1.star(451, 47, 0.6);
  }
}

void GameOver() {
  fill(105,105,105,240);
  rect(0,0, width, height);
  santa.resize(150, 150);
  tint(255, 210);
  image(santa, width/2, 310);
  textAlign(CENTER);
  textFont(mono);
  fill(181, 17, 17);
  text("GAME OVER", width/2, 450);
  sound.pause();
  gameover.play();
}

void YouWin(){
  fill (105, 105, 105, 240);
  rect (0,0, width, height);
  santa2.resize(150, 150); 
  tint(255, 210); 
  image(santa2, width/2, 310);
  //textAlign(CENTER);
  textFont(mono); 
  fill (random(255), random(255), random(255));
  text("YOU WIN!", 270, 450);
  

  sound.pause();
  fanfare.play(); 
  
    
  update2(mouseX, mouseY);
  
  if (rectOver2) {
   fill(rectHighlight2);
  } else {
   fill(rectColor2);
  }

  rect(rectX2, rectY2, rectSize12, rectSize22);
  textFont(bono);
  fill(255);
  text("RESTART", rectX + 27, rectY + 155);
  
  if (circleOver2) {
   fill(circleHighlight2);
  } else {
   fill(circleColor2);
  }

  ellipse(circleX2, circleY2, circleSize2, circleSize2);
  textFont(bono);
  fill(255);
  text("QUIT", circleX- 28, circleY + 120);
}

void levelUpScreen(){
  
  fill (105, 105, 105, 240); 
  rect (0,0, width, height); 
  coolface.resize(150, 150); 
  image(coolface, width/2, 310);  
  textFont(mono); 
  fill (238, 250, 83); 
  text("LEVEL UP!", 264, 450);
  
}



void levelUp(){
 if (((xBounds[0] >= 370 && xBounds[0] <= 470) && (xBounds[1] >= 370 && xBounds[1] <= 470)) && ((yBounds[0] >= 38 && yBounds[0] <=128) && (yBounds[1] >= 38 && yBounds[1] <=128))){
   level++;
   speedlevel++;
   createVehicles();
   if (level <=3){
        sound.pause();
        levelup.loop(0);
        levelTimer = millis() + 1000;
        displayLevelUp = true;
        levelUpScreen();
   }
   knight.position.x = 420;
   knight.position.y = 780; 
  

 }
}
 
void keyPressed()
{
  if (keyCode == RIGHT)
  {
      right = 5;
  }
  if (keyCode == LEFT)
  {
      left = -5;
  }
  if (keyCode == UP)
  {
      up = -5;
  }
  if (keyCode == DOWN)
  {
      down = 5;
  }
  //Pause
  if(keyCode == ENTER){
    if(pause == false){
       pause = true;
    
    }

   }     
}
 
void pauseScreen() {
  fill(105,105,105,210);
  rect(0,0, width, height);
  textFont(mono);
  fill(213, 167, 39, 200);
  text("PAUSE", 320, height/2.45);
  
  update(mouseX, mouseY);
  
  if (rectOver) {
   fill(rectHighlight);
  } else {
   fill(rectColor);
  }

  rect(rectX, rectY, rectSize1, rectSize2);
  textFont(bono);
  fill(255);
  text("CONTINUE", rectX + 16, rectY + 40);
  
  if (circleOver) {
   fill(circleHighlight);
  } else {
   fill(circleColor);
  }

  ellipse(circleX, circleY, circleSize, circleSize);
  textFont(bono);
  fill(255);
  text("QUIT", circleX- 28, circleY + 7);
  
  sound.pause();
}

void keyReleased()
{
  if (keyCode == RIGHT)
  {
    right = 0;
  }
  if (keyCode == LEFT)
  {
    left = 0;
  }
  if (keyCode == UP)
  {
    up = 0;
  }
  if (keyCode == DOWN) 
  {
    down = 0;
  }
}

void scaleShapes() {
  house.scale(0.3);
  pushMatrix();
  car.scale(0.2);
  popMatrix();
  pushMatrix();
  truck.scale(-0.25,0.25);
  popMatrix();
  pushMatrix();
  race.scale(0.25);
  popMatrix();
  pushMatrix();
  car2.scale(0.25);
  popMatrix();
  pushMatrix();
  train.scale(0.25);
  train1.scale(0.25);
  train2.scale(0.25);
  train3.scale(0.25);
  popMatrix();
}

void update(int x, int y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  } else if ( overRect(rectX, rectY, rectSize1, rectSize2) ) {
    rectOver = true;
    circleOver = false;
  } else {
    circleOver = rectOver = false;
  }
}

void update2(int x, int y) {
  if ( overCircle(circleX2, circleY2, circleSize2) ) {
    circleOver2 = true;
    rectOver2 = false;
  } else if ( overRect(rectX2, rectY2, rectSize12, rectSize22) ) {
    rectOver2 = true;
    circleOver2 = false;
  } else {
    circleOver2 = rectOver2 = false;
  }
}



  
  void mousePressed() {
  if (circleOver) {
    exit();
  }
  if (rectOver) {
    pause = false; 
  }
  if (circleOver2) {
    exit();
  }
  if (rectOver2) {
    fanfare.pause(); 
    setup(); 
    
  }
  }

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}




void drawRoad() {
   //Sky
  noStroke();
  fill(#87CEFA);
  rect(0, 0, 840, 120);
  //House
  fill(#CCB322);
  rect(390, 38, 65, 90);
  shape(house, 345, -22);
  //Bottom
  noStroke();
  fill(#458B00);
  rect(0, 720, 840, 120);
  //Street
  noStroke();
  fill(#282B2A);
  rect(0,120, 840,600);
  //Center Stripes
  for(int i = 1; i <= 4; i++) {
    for(int j = 0; j <= 18; j++) { 
      fill(#ffff00);
      rect(50*j+5, 120*i+120, 30, 4);
    }
  }
}