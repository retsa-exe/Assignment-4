/////////////////////////////
//Assignment 4: zombie sims//
//by: Aster Lin            //
//ID: 991786760            //
/////////////////////////////


int speed=2;

zombies zombie;
ArrayList<citizen> citizens;

void setup() {
  size(800, 600); //set a default window size for testing, may change to full screen if there is more time

  zombie= new zombies (width/2, height/2); //initialize zombie

  //initialize citizens
  citizens = new ArrayList<citizen>();
  for (int i = 0; i < 10; i++) {
    citizens.add(new citizen(random(width), random(height)));
  }
}

void draw() {
  //update background
  background(0);

  //update and draw citizens
  for (int i = 0; i < citizens.size(); i++) {
    citizens.get(i).update();
    citizens.get(i).display();
    citizen c = citizens.get(i);
    if (isCloseToZombie(zombie, c)) {
      fill(255, 0, 0);
      text("AHHHHHHHH!", c.pos.x + 10, c.pos.y - 10);

      c.stayNearZombie(); 
      zombie.stayNearCitizen(); 

      if (c.isTimeToRemove()) {
        citizens.remove(i);
        i--; 
      }
    }
  }

  //move the zombie
  if (zombie.isTimeToMove() && keyPressed) { // 检查僵尸是否可以移动
    if (keyCode == UP) {
      zombie.move(0, -speed);
    } else if (keyCode == DOWN) {
      zombie.move(0, speed);
    } else if (keyCode == LEFT) {
      zombie.move(-speed, 0);
    } else if (keyCode == RIGHT) {
      zombie.move(speed, 0);
    }
  }

  //draw zombie
  zombie.display();
}

boolean isCloseToZombie(zombies z, citizen c) {
  float distance = PVector.dist(z.pos, c.pos);
  return distance < 60;
}
