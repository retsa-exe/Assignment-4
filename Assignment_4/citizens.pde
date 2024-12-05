class citizen {
  PVector pos;
  PVector velocity;
  int closeStartTime;
  boolean stayingNearZombie;
  int direction=1;

  int eatenFrame=0;
  int individualCitizenFrame=0;


  boolean isEaten = false;

  citizen(float x, float y) {
    pos = new PVector(x, y);
    velocity = PVector.random2D().mult(1); // Initialize with random velocity
    stayingNearZombie = false;
  }

  void update() {
    if (isEaten) {
      if (frameCount % 10 == 0) {
        eatenFrame = (eatenFrame + 1) % citizenEaten.length;
      }
    } else {
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
        individualCitizenFrame = (individualCitizenFrame + 1) % citizenWalk.length;
      }
    }
  }


  void display() {
    pushMatrix();
    translate(pos.x, pos.y);

    if (isEaten) {
      image(citizenEaten[eatenFrame], 0, 0);
    } else {
      scale(direction, 1);
      image(citizenWalk[individualCitizenFrame], 0, 0);
    }

    popMatrix();
  }


  void stayNearZombie() {
    if (!stayingNearZombie && !isEaten) {
      closeStartTime = millis();
      stayingNearZombie = true;
      velocity = new PVector(0, 0);
      isEaten = true;
    }
  }


  boolean isTimeToRemove() {
    if (isEaten && eatenFrame == citizenEaten.length - 1) {
      return true;
    }
    return false;
  }
}
