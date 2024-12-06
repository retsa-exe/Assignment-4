/////////////////////////////
//Assignment 4: zombie sims//
//by: Aster Lin            //
//ID: 991786760            //
/////////////////////////////

//character arts from: https: www.kenney.nl

int gameState= 0; //0: start screen, 1: game running, 2: game over, 3: player wins

int speed=2;

zombies zombie;
ArrayList<citizen> citizens;
ArrayList<cop> cops;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

PImage zombieImage;
PImage zombieWalk[];

PImage citizenWalk[];

PImage copWalk[];

boolean isWalking;
int zombieFrame;

PImage citizenEaten[];

PImage background, startPage, winPage, losePage;
PImage AHH;

void setup() {
  size(800, 600); //set a default window size for testing, may change to full screen if there is more time

  imageMode(CENTER);

  zombieImage = loadImage("zombie_stand.png");

  zombieWalk = new PImage[2];
  zombieWalk[0] = loadImage("zombie_walk1.png");
  zombieWalk[1] = loadImage("zombie_walk2.png");

  zombie= new zombies (width/2, height/2); //initialize zombie

  citizenWalk = new PImage[2];
  citizenWalk[0] = loadImage("citizen_walk1.png");
  citizenWalk[1] = loadImage("citizen_walk2.png");

  copWalk = new PImage[2];
  copWalk[0] = loadImage("cop_walk1.png");
  copWalk[1] = loadImage("cop_walk2.png");

  citizenEaten = new PImage[3];
  citizenEaten[0] = loadImage("citizen_eaten1.png");
  citizenEaten[1] = loadImage("citizen_eaten2.png");
  citizenEaten[2] = loadImage("citizen_eaten3.png");

  background = loadImage("background.png");
  startPage =loadImage("startPage.png");
  winPage =loadImage("winPage.png");
  losePage =loadImage("losePage.png");

  AHH = loadImage("AHH.png");

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
    image(startPage, width/2, height/2);
  } else if (gameState == 1) {
    //update background
    image(background, width/2, height/2);

    if (frameCount % 10 == 0) {
      zombieFrame = (zombieFrame + 1) % zombieWalk.length;
    }

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
        image(AHH, c.pos.x, c.pos.y-50);

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

    if (leftPressed || rightPressed || upPressed || downPressed) {
      isWalking=true;
    } else {
      isWalking=false;
    }

    //draw zombie
    zombie.display();
  } else if (gameState == 2) {
    // Game over screen

    image(losePage, width/2, height/2);
  } else if (gameState ==3) {

    image(winPage, width/2, height/2);
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
      zombie.direction=-1;
    } else if (keyCode == RIGHT) {
      rightPressed = true;
      zombie.direction=1;
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
