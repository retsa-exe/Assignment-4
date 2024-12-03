class zombies {
  PVector pos;

  zombies(float x, float y) {
    pos= new PVector(x, y);
  }
  
  void move(float dx,float dy) {
    pos.add(new PVector(dx,dy));
    
    //restrict zombie position
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }

  void display() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, 50, 70);
  }
}
