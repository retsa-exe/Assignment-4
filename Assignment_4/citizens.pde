class citizen {
  PVector pos;
  PVector velocity;
  int closeStartTime;
  boolean stayingNearZombie;
  int direction=1;
  
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
    
    if (velocity.x > 0) {
      direction = 1; 
    } else if (velocity.x < 0) {
      direction = -1; 
    }
  }
  
  void display() {
    fill(0, 0, 255);
    
    pushMatrix();
    translate(pos.x, pos.y);
    scale(direction, 1);
    image(citizenWalk[citizenFrame], 0, 0);
    popMatrix();
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
