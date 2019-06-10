class Walker
{
  PImage image;
  PVector position;
  int frameRow;
  int frameColumn;
  float frameTimer;
  PVector velocity;
  float speed;
  float x, y;
  
  Walker() {
    image = loadImage("animate.png");
    position = new PVector(420, 780);
    velocity = new PVector(0, 0);
    frameRow = 0; // which row from source image to use
    frameColumn = 0; // which column from source image to use
    frameTimer = 0; // determines which column to use to animate.
    speed = 1; // walk speed
  }
  
  void updateBounds() {
    xBounds[0] = (knight.position.x - 45) + 23;
    xBounds[1] = xBounds[0] + 40;
    yBounds[0] = (knight.position.y - 45) + 10;
    yBounds[1] = yBounds[0] + 68;
  }
  
  void selectFrame() {
    knight.position.add(knight.velocity);
    knight.frameTimer += 0.5; // 0.1 is the framerate or speed of animation.
    if (knight.frameTimer >= 5) // reset at 6 because there's only 0-5 columns in the spritesheet
    {
      knight.frameTimer = 0.5; // column 1 is the first frame of the walk animation
    }
    knight.frameColumn = (int)knight.frameTimer; // cast the timer to an int so it's an integer between 1 and 5
     
    if (knight.velocity.x == 0 && knight.velocity.y == 0)
    {
      knight.frameColumn = 0; //column 0 is the stopped frame of animation
    }
    if (left != 0)
    {
      knight.frameRow = 0; // column 1 is the left facing animation
    }
    if (right != 0)
    {
      knight.frameRow = 1; // column 3 is the right facing animation
    }
    if (up != 0)
    {
      knight.frameRow = 2; // etc.
    }
    if (down != 0)
    {
      knight.frameRow = 3; // etc.
    }
    pushMatrix();
    translate(knight.position.x, knight.position.y);
    frameImage = getSubImage(knight.image, knight.frameRow, knight.frameColumn, 90, 90);
  }
  
  void display() {
    updateBounds();
    boundsCheck();
    selectFrame();
    imageMode(CENTER);
    image(frameImage, 0, 0);
    popMatrix();
  }
}