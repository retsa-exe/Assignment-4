class zombies {
  PVector pos;
  boolean stayingNearCitizen;
  int stopStartTime;

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
    ellipse(pos.x, pos.y, 50, 70);
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
