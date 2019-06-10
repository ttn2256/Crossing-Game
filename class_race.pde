class Race { 
  float xpos;
  float ypos;
  float xspeed;
 
  Race(float tempXpos, float tempYpos, float tempXspeed) { // The Constructor is defined with arguments.
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }
 
  void display() {
    move();
    shape(race, xpos, ypos);

  }
 
  void move() {
    xpos = xpos + xspeed;
     if (xpos > width + 250) {
       xpos = -400;
     }
    updateBounds();
  }
  
  void updateBounds() {
    xRace[0] = xpos + 2;
    xRace[1] = xRace[0] + 120;
    yRace[0] = ypos + 48;
    yRace[1] = yRace[0] + 30;
  }
}