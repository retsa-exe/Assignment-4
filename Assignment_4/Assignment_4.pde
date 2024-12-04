/////////////////////////////
//Assignment 4: zombie sims//
//by: Aster Lin            //
//ID: 991786760            //
/////////////////////////////

int gameState= 0; //0: start screen, 1: game running, 2: game over, 3: player wins

int speed=2;

zombies zombie;
ArrayList<citizen> citizens;
ArrayList<cop> cops;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup() {
  size(800, 600); //set a default window size for testing, may change to full screen if there is more time

  zombie= new zombies (width/2, height/2); //initialize zombie

  //initialize citizens
  citizens = new ArrayList<citizen>();
  for (int i = 0; i < 10; i++) {
    citizens.add(new citizen(random(width), random(height)));
  }

  //initialize coops
  cops = new ArrayList<cop>();
  for (int i = 0; i < 5; i++) {
    cops.add(new cop(random(width), random(height)));
  }
}

void draw() {
  if (gameState == 0) {
    // Start screen
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("Zombie Simulator", width / 2, height / 2 - 50);
    textSize(20);
    text("Press ENTER to start", width / 2, height / 2 + 50);
  } else if (gameState == 1) {
    //update background
    background(0);
    
    //check the winning condition
    if (citizens.size()==0) {
      gameState = 3; 
    }

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

    //update and draw cops
    for (int i = 0; i < cops.size(); i++) {
      cop c = cops.get(i);
      c.update();
      c.display();

      // Detect distance between zombie and cops
      if (isCloseToCop(zombie, c)) {

        zombie.stayNearCop(); // Stop zombie movement
        gameState= 2; //game over
      }
    }

    //move the zombie
    if (zombie.isTimeToMove()) {
      if (upPressed && leftPressed) {
        zombie.move(-speed, -speed);
      } else if (upPressed && rightPressed) {
        zombie.move(speed, -speed);
      } else if (downPressed && leftPressed) {
        zombie.move(-speed, speed);
      } else if (downPressed && rightPressed) {
        zombie.move(speed, speed);
      } else if (upPressed) {
        zombie.move(0, -speed);
      } else if (downPressed) {
        zombie.move(0, speed);
      } else if (leftPressed) {
        zombie.move(-speed, 0);
      } else if (rightPressed) {
        zombie.move(speed, 0);
      }
    }

    //draw zombie
    zombie.display();
  } else if (gameState == 2) {
    // Game over screen (optional)
    background(0);
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(32);
    text("Game Over", width / 2, height / 2 - 50);
    textSize(20);
    text("Press R to restart", width / 2, height / 2 + 50);
    
  } else if (gameState ==3){
    background(0);
    fill(0, 255, 0);
    textAlign(CENTER);
    textSize(32);
    text("You Win!", width / 2, height / 2 - 50);
    textSize(20);
    text("Press R to restart", width / 2, height / 2 + 50);
  }
}

boolean isCloseToZombie(zombies z, citizen c) {
  float distance = PVector.dist(z.pos, c.pos);
  return distance < 60;
}

boolean isCloseToCop(zombies z, cop c) {
  float distance = PVector.dist(z.pos, c.pos);
  return distance < 60;
}

void keyPressed() {
  if (gameState == 0) {
    if (key == ENTER) {
      gameState = 1; // Start the game
    }
  } else if (gameState == 1) {
    if (keyCode == UP) {
      upPressed = true;
    } else if (keyCode == DOWN) {
      downPressed = true;
    } else if (keyCode == LEFT) {
      leftPressed = true;
    } else if (keyCode == RIGHT) {
      rightPressed = true;
    }
  } else if (gameState == 2 || gameState == 3) {
    if (key == 'R' || key == 'r') {
      setup(); // Restart the game
      gameState = 0; // Go back to start screen
    }
  }
}

void keyReleased() {
  if (keyCode == UP) {
    upPressed = false;
  } else if (keyCode == DOWN) {
    downPressed = false;
  } else if (keyCode == LEFT) {
    leftPressed = false;
  } else if (keyCode == RIGHT) {
    rightPressed = false;
  }
}
