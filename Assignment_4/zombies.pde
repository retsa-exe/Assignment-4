class zombies {
  PVector pos; //zombie positions 
  boolean stayingNearCitizen;
  int stopStartTime;
  int direction = 1;

  zombies(float x, float y) {
    pos = new PVector(x, y);
    stayingNearCitizen = false;
  }

  void move(float dx, float dy) {
    if (!stayingNearCitizen) { // zombie only move when not eating citizens
      pos.add(new PVector(dx, dy));

      // Restrict zombie position
      pos.x = constrain(pos.x, 0, width);
      pos.y = constrain(pos.y, 0, height);
    }
  }

  void display() {
    noStroke();
    fill(255);

    //flip the picture accrding to the directions
    pushMatrix();
    translate(pos.x, pos.y);
    scale(direction, 1);
    
    if (isWalking) {
      //walking animations
      image(zombieWalk[zombieFrame%2], 0, 0);
    } else {
      //standing animations
      image(zombieImage, 0, 0);
    }
    popMatrix();
  }

  //record the time when catch a citizen
  void stayNearCitizen() {
    if (!stayingNearCitizen) {
      stopStartTime = millis();
      stayingNearCitizen = true;
    }
  }

  //detect if its time to move
  boolean isTimeToMove() {
    if (stayingNearCitizen && millis() - stopStartTime >= 3000) {
      stayingNearCitizen = false; // zombie can move now
    }
    return !stayingNearCitizen;
  }

  void stayNearCop() {
    if (!stayingNearCitizen) { // Ensure it doesn't conflict with citizen logic
      stopStartTime = millis();
      stayingNearCitizen = true;
    }
  }
}
