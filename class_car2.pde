class Car2 { 
  float xpos;
  float ypos;
  float xspeed;
 
  Car2(float tempXpos, float tempYpos, float tempXspeed) { // The Constructor is defined with arguments.
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }
 
  void display() {
    //scale(0.2);
    move();
    pushMatrix();
    shape(car2, xpos, ypos);
    popMatrix();
  }
 
  void move() {
    xpos = xpos - xspeed;
    if (xpos < - 200) {
      xpos = 1040;
    }
    updateBounds();
  }
  
  void updateBounds() {
    xCar2[0] = xpos + 2;
    xCar2[1] = xCar2[0] + 120;
    yCar2[0] = ypos + 44;
    yCar2[1] = yCar2[0] + 40; 
  }
}