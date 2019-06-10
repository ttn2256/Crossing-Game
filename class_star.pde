class Star {
  
PShape star;   

void star (float x, float y, float z) {     
  // First create the shape
  star = createShape();
  star.beginShape();
  star.vertex(0, -50);
  star.vertex(14, -20);
  star.vertex(47, -15);
  star.vertex(23, 7);
  star.vertex(29, 40);
  star.vertex(0, 25);
  star.vertex(-29, 40);
  star.vertex(-23, 7);
  star.vertex(-47, -15);
  star.vertex(-14, -20);
  star.endShape(CLOSE);
  
  star.scale(0.25);
  star.rotate(z);
 
  shape(star, x, y);
  
}
    
}