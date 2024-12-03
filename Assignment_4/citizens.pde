class citizen {
  PVector pos;
  PVector velocity;
  int closeStartTime;
  boolean stayingNearZombie;
  
  citizen(float x, float y) {
    pos = new PVector(x, y);
    velocity = PVector.random2D().mult(1); // Initialize with random velocity
    stayingNearZombie = false;
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
  
  void display() {
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, 50, 70);
  }
  
  void stayNearZombie() {
    if (!stayingNearZombie) {
      closeStartTime = millis();
      stayingNearZombie = true;
      velocity = new PVector(0, 0); // stop moving 
    }
  }
  
  boolean isTimeToRemove() {
    if (stayingNearZombie && millis() - closeStartTime >= 3000) {
      return true;
    }
    return false;
  }
}
