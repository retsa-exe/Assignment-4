class cop{
  PVector pos;
  PVector velocity;
  
  cop(float x, float y) {
    pos = new PVector(x, y);
    velocity = PVector.random2D().mult(1); // Initialize with random velocity
  }
  
  void update() {
    pos.add(velocity);
    
    // Keep the citizen within the window boundaries
    if (pos.x < 0 || pos.x > width) {
      velocity.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      velocity.y *= -1;
    }
  }
  
  void display(){
    noStroke();
    fill(255,0,0);
    ellipse(pos.x,pos.y, 50,70);
  }
}
