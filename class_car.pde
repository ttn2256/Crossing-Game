class Car { 
  float xpos;
  float ypos;
  float xspeed;

  Car(float tempXpos, float tempYpos, float tempXspeed) { // The Constructor is defined with arguments.
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }
 
  void display() {
    move();
    shape(car, xpos, ypos);
  }
 
  void move() {
    xpos = xpos + xspeed;
    if (xpos > width + 200) {
     xpos = -200;
    }
    updateBounds();
  }
  
  void updateBounds() {
    xCar[0] = xpos + 2;
    xCar[1] = xCar[0] + 100;
    yCar[0] = ypos + 58;
    yCar[1] = yCar[0] + 32;
    xCarTop[0] = xpos + 12;
    xCarTop[1] = xCarTop[0] + 64;
    yCarTop[0] = ypos + 36;
    yCarTop[1] = yCarTop[0] + 22;
    xCarLight[0] = xpos + 26;
    xCarLight[1] = xCarLight[0] + 36;
    yCarLight[0] = ypos + 12;
    yCarLight[1] = yCarLight[0] + 24;
    //noFill();
    //stroke(255);
    //rect(xpos + 26, ypos + 12, 36, 24);
  }
}