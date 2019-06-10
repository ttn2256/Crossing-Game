class Truck { 
  float xpos;
  float ypos;
  float xspeed;
 
  Truck(float tempXpos, float tempYpos, float tempXspeed) { // The Constructor is defined with arguments.
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }
 
  void display() {
    //scale(-1.2,1);
    move();
    shape(truck, xpos, ypos);

  }
 
  void move() {
    xpos = xpos - xspeed;
    if (xpos < - 200) {
      xpos = 1040;
    }
    updateBounds();
  }
  
  void updateBounds() {
    xTruck[0] = xpos - 128;
    xTruck[1] = xTruck[0] + 126;
    yTruck[0] = ypos+20;
    yTruck[1] = yTruck[0] + 86;
  }
}