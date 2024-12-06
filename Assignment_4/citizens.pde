class citizen {
  PVector pos; //the position of the citizen
  PVector velocity; //the direction of the citizen
  boolean stayingNearZombie;
  int direction=1; //the direction for the animation
  
  //the frame for animation
  int eatenFrame=0;
  int individualCitizenFrame=0;

  //variables for the eaten state
  boolean isEaten = false;
  int eatenStartTime = 0; 
  int eatenDuration = 3000; 


  citizen(float x, float y) {
    pos = new PVector(x, y); 
    velocity = PVector.random2D().mult(1); // Initialize with random velocity
    stayingNearZombie = false;
  }

  void update() {
    if (isEaten) {
      //update the pictures every 10 frames
      if (frameCount % 10 == 0) {
        eatenFrame = (eatenFrame + 1) % citizenEaten.length;
      }
    } else {
      
      //move the citizens
      pos.add(velocity);
      
      //flip the image accroding to the direction
      if (velocity.x > 0) {
        direction = 1;
      } else if (velocity.x < 0) {
        direction = -1;
      }
      
      //bounce back near edges
      if (pos.x < 0 || pos.x > width) {
        velocity.x *= -1;
      }
      if (pos.y < 0 || pos.y > height) {
        velocity.y *= -1;
      }
      
      //update walking pictures every 10 frames
      if (frameCount % 10 == 0) {
        individualCitizenFrame = (individualCitizenFrame + 1) % citizenWalk.length;
      }
    }
  }


  void display() {
    
    //flip the image accrding to the directions
    pushMatrix();
    translate(pos.x, pos.y);
    
    //play the eaten animation
    if (isEaten) {
      image(citizenEaten[eatenFrame], 0, 0);
    } else {
      
      //play the walking anamations
      scale(direction, 1);
      image(citizenWalk[individualCitizenFrame], 0, 0);
    }

    popMatrix();
  }

  //detect if is near to zombie
  void stayNearZombie() {
    if (!stayingNearZombie && !isEaten) {
      stayingNearZombie = true;
      velocity = new PVector(0, 0);  //stop the zombie
      isEaten = true; 
      eatenStartTime = millis(); //record the time when the eating starts
    }
  }

  //detect if its time to remove
  boolean isTimeToRemove() {
    if (isEaten && millis() - eatenStartTime >= eatenDuration) {
      return true;
    }
    return false;
  }
}
