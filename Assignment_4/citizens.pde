class citizen {
  PVector pos;
  
  citizen(float x, float y) {
    pos = new PVector(x, y);
  }
  
  void update() {
  }
  
  void display() {
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, 50, 70);
  }
}
