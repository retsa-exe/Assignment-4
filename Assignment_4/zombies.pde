class zombies {
  PVector pos;

  zombies(float x, float y) {
    pos= new PVector(x, y);
  }
  
  void move(float dx,float dy) {
    pos.add(new PVector(dx,dy));
  }

  void display() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, 50, 70);
  }
}
