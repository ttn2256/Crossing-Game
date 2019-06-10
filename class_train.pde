class Train { 
  float xpos;
  float ypos;
  float xspeed;

  Train(float tempXpos, float tempYpos, float tempXspeed) { // The Constructor is defined with arguments.
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }
 
  void display() {  
    move();
    shape(train, xpos, ypos);
    shape(train1, xpos - 120, ypos + 15 );
    shape(train2, xpos - 240, ypos + 15);
    shape(train3, xpos - 360, ypos + 15);

  }
 
  void move() {
    xpos = xpos + xspeed;
    if (xpos > width + 350) {
      xpos = -220;
    }
    updateBounds();
  }
  
  void updateBounds() {
    xTrain[0] = xpos + 2;
    xTrain[1] = xTrain[0] + 120;
    yTrain[0] = ypos + 18;
    yTrain[1] = yTrain[0] + 90;
    xCaboose[0] = xpos - 365;
    xCaboose[1] = xCaboose[0] + 360;
    yCaboose[0] = ypos + 48;
    yCaboose[1] = yCaboose[0] + 60;
  }
  
}