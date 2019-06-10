class Lives {
  float x,y;
  
  Lives (float _x, float _y){
    x = _x;
    y = _y;
  }
  
  void display(){
    shape (livesVector, x, y); 
  }
}