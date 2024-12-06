class cop {
  PVector pos; //cop position
  PVector velocity;
  int direction;

  int frame; //the anamation frame

  cop(float x, float y) {
    pos = new PVector(x, y);
    velocity = PVector.random2D().mult(1); // Initialize with random velocity
  }

  void update() {

    // Keep the cops within the window boundaries
    pos.add(velocity);

    if (velocity.x > 0) {
      direction = 1;
    } else if (velocity.x < 0) {
      direction = -1;
    }

    if (pos.x < 0 || pos.x > width) {
      velocity.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      velocity.y *= -1;
    }

    if (frameCount % 10 == 0) {
      frame = (frame + 1) % copWalk.length; //update images every 10 frames
    }
  }

  void display() {
    
    //show the image according to the directions 
    pushMatrix();
    translate(pos.x, pos.y);

    scale(direction, 1);
    image(copWalk[frame], 0, 0);

    popMatrix();
  }
}
