/////////////////////////////
//Assignment 4: zombie sims//
//by: Aster Lin            //
//ID: 991786760            //
/////////////////////////////

//character arts from: https: www.kenney.nl

int gameState= 0; //0: start screen, 1: game running, 2: game over, 3: player wins

int speed=2; //the speed of the zombie

//list the objects and arrayLists
zombies zombie;
ArrayList<citizen> citizens;
ArrayList<cop> cops;

//boolean variables detecting keys
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

boolean isWalking; //zombie walking state
int zombieFrame; //frame for zombie animation

//PImages variables

PImage zombieImage;
PImage zombieWalk[];

PImage citizenWalk[];

PImage copWalk[];

PImage citizenEaten[];

PImage background, startPage, winPage, losePage;

PImage AHH; //the text effect variable

void setup() {
  //print instructions
  
  println("Eat all the citizens! Don't get caught!");
  println("use arrows to move around");
  
  size(800, 600); //set a default window size for testing, may change to full screen if there is more time

  imageMode(CENTER); //

  //load zombie images
  zombieImage = loadImage("zombie_stand.png");

  zombieWalk = new PImage[2];
  zombieWalk[0] = loadImage("zombie_walk1.png");
  zombieWalk[1] = loadImage("zombie_walk2.png");

  zombie= new zombies (width/2, height/2); //initialize zombie
  
  //load citizen images
  citizenWalk = new PImage[2];
  citizenWalk[0] = loadImage("citizen_walk1.png");
  citizenWalk[1] = loadImage("citizen_walk2.png");
  
  //load cop images
  copWalk = new PImage[2];
  copWalk[0] = loadImage("cop_walk1.png");
  copWalk[1] = loadImage("cop_walk2.png");
  
  //load citizen eaten images
  citizenEaten = new PImage[3];
  citizenEaten[0] = loadImage("citizen_eaten1.png");
  citizenEaten[1] = loadImage("citizen_eaten2.png");
  citizenEaten[2] = loadImage("citizen_eaten3.png");
  
  //load title page, background, win and lose page
  background = loadImage("background.png");
  startPage =loadImage("startPage.png");
  winPage =loadImage("winPage.png");
  losePage =loadImage("losePage.png");
  
  //load text effect image
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
    //show the start page
    image(startPage, width/2, height/2);
  } else if (gameState == 1) {
    
    //main logic of the game below
    
    //update background
    image(background, width/2, height/2);
  
    //set zombie frame
    if (frameCount % 10 == 0) { //the pictures will change every 10 frames
      zombieFrame = (zombieFrame + 1) % zombieWalk.length; //make sure the frame updates
    }

    //check the winning condition
    if (citizens.size()==0) { //all the citizens are gone
      gameState = 3; //set game sate to winning
    }

    //update and draw citizens
    for (int i = 0; i < citizens.size(); i++) {
      citizens.get(i).update();
      citizens.get(i).display();
      citizen c = citizens.get(i); //for each citizen in the arrayList
      //detect if its too close to zombie
      if (isCloseToZombie(zombie, c)) {
        image(AHH, c.pos.x, c.pos.y-50); //pop up the text effect
        
        //froze both zombie and citizen
        c.stayNearZombie(); 
        zombie.stayNearCitizen();
        
        //check if its time to remove the citizen
        if (c.isTimeToRemove()) {
          citizens.remove(i);
          i--;
        }
      }
    }

    //update and draw cops
    for (int i = 0; i < cops.size(); i++) {
      cop c = cops.get(i); //for each cop in the arrayList
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
      //detect if multiple keys are pressed
      if (upPressed && leftPressed) {
        zombie.move(-speed, -speed);
      } else if (upPressed && rightPressed) {
        zombie.move(speed, -speed);
      } else if (downPressed && leftPressed) {
        zombie.move(-speed, speed);
      } else if (downPressed && rightPressed) {
        zombie.move(speed, speed);
        
        //then detect keys individually
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
    
    //show the walking animation if the zombie is walking
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
    
    //winning screen
    image(winPage, width/2, height/2);
  }
}

//detect if the citizen is too close to zombie
boolean isCloseToZombie(zombies z, citizen c) {
  float distance = PVector.dist(z.pos, c.pos);
  return distance < 60;
}

//detect if the zombie is too close to cops
boolean isCloseToCop(zombies z, cop c) {
  float distance = PVector.dist(z.pos, c.pos);
  return distance < 60;
}

void keyPressed() {
  if (gameState == 0) {   //in the title page
    if (key == ENTER) {
      gameState = 1; // Start the game
    }
  } else if (gameState == 1) { //when the game is running
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
  } else if (gameState == 2 || gameState == 3) { //if the game ends
    if (key == 'R' || key == 'r') {
      setup(); // Restart the game
      gameState = 0; // Go back to start screen
    }
  }
}

//set the booleans to false when the key released
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
