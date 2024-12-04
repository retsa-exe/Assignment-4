class zombies {
  PVector pos;
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

    pushMatrix();
    translate(pos.x, pos.y);
    scale(direction, 1);
    if (isWalking) {
      image(zombieWalk[zombieFrame%2], 0, 0);
    } else {
      image(zombieImage, 0, 0);
    }
    popMatrix();
  }

  void stayNearCitizen() {
    if (!stayingNearCitizen) {
      stopStartTime = millis();
      stayingNearCitizen = true;
    }
  }

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
