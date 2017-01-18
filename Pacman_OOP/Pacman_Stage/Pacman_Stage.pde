//Pacman v2
//Richard Cao
//Extra For Experts: Learned how to use a collision map
//Movement entirely reworked, less clunky than before
//Added AI movement, behaviour, interaction with player (and it took super long)
//Added Frenzy mode, allowing Pacman to eat ghosts if he recently ate a pink power dot
//More like PacMan game now, as PacMan can die or eat the ghosts
//Gameover is the same if you win or lose
//Added array of objects is the Arraylists of dots and ghosts

//stores dots and power dots
ArrayList <Dots> dots = new ArrayList <Dots>();
ArrayList <PowerDots> powerDots = new ArrayList<PowerDots>();

PImage colMapImage, mapImage;

Pacman player;

//array list
Ghost [] theGhosts = new Ghost[3];

void setup() {
  //setup window
  size(640, 480);

  //setup player
  player = new Pacman();

  //setup ghosts
  theGhosts[0] = new Ghost(287, 213, 0, 2);
  theGhosts[1] = new Ghost(320, 213, 1, 2);
  theGhosts[2] = new Ghost(352, 213, 2, 3);
  
  //setup ghost images
  for(int i = 0; i<theGhosts.length; i++){
    theGhosts[i].ghostImage[0] = loadImage("ghost_" + i + ".png");
    theGhosts[i].ghostImage[0].resize(theGhosts[i].size, theGhosts[i].size);
    theGhosts[i].ghostImage[1] = loadImage("ghost_3.png");
    theGhosts[i].ghostImage[1].resize(theGhosts[i].size, theGhosts[i].size);
  }

  //loads collision map
  colMapImage = loadImage("pacman_collisionmap.gif");
  //colMapImage.resize(625, 480);
  CollisionMap();

  //sets up map image
  mapImage = loadImage("pacman_blankmap.png");
  //mapImage.resize(625, 480);
  imageMode(CENTER);

  //loads sprite images
  for (int i = 0; i < 3; i++) {
    playerLeft[i] = loadImage("pacman_LEFT_" + i + ".png");
    playerRight[i] = loadImage("pacman_RIGHT_" + i + ".png");
    playerUp[i] = loadImage("pacman_UP_" + i + ".png");
    playerDown[i] = loadImage("pacman_DOWN_" + i + ".png");

    playerLeft[i].resize(player.size, player.size);
    playerRight[i].resize(player.size, player.size);
    playerUp[i].resize(player.size, player.size);
    playerDown[i].resize(player.size, player.size);
  }

  //sets up dots  
  //rows
  for (int i = 126; i < colMapImage.width; i+= 32) {
    //columns
    for (int j = 30; j < colMapImage.height; j+= 32) {
      //if the place is a corridor and not a wall
      if (collisionMap[i][j] == true) {
        //create a dot at that location
        Dots aDot = new Dots(i, j);
        dots.add(aDot);
      }
    }
  }

  //setup power dots
  PowerDots topLeft = new PowerDots(124, 30);
  PowerDots topRight = new PowerDots(509, 30);
  PowerDots botLeft = new PowerDots(125, 414);
  PowerDots botRight = new PowerDots(510, 414);
  powerDots.add(topLeft);
  powerDots.add(topRight);
  powerDots.add(botLeft);
  powerDots.add(botRight);
}

void draw() {
  //draws the map
  image(mapImage, width/2, height/2);

  //draws a grid for debugging
  //  for(int i = 110; i < width; i+= 30){
  //    stroke(255,0,0);
  //    line(i, 0, i, height);
  //  }
  //  for(int j = 15; j < height; j += 30){
  //    line(0, j, width, j);
  //  }

  //
  for (int i = 0; i<theGhosts.length; i++) {
    if (!theGhosts[i].outOfPen) {
      //the ghosts will leave the pen if they are in it
      theGhosts[i].leavePen();
    } else {
      //the ghosts will move
      theGhosts[i].Wander();
      //if the ghosts and pacman collide...
      if ((theGhosts[i].x + 10) > (player.x - 10) && (theGhosts[i].y + 10) > (player.y - 10) && (player.x + 10) > (theGhosts[i].x - 10) && (player.y + 10) > (theGhosts[i].y - 10)) {  
        if (!frenzied) {
          //...PacMan will die if not frenzied
          GameOver();
        }
        //...or Pacman will eat them if in frenzy mode
        else {
          theGhosts[i].GetEaten();
        }
      }
    }
    theGhosts[i].display();
  }

    //toggles action based on whether the mode is frenzied or normal
    if (!frenzied) {
      //deletes power dots if pacman eats it
      GainPower();
    } else {
      //stops frenzy mode after 3 seconds
      if (millis() - frenzyTimer > 3000) {
        frenzied = false;
      }
    }


    //keeps collision map going
    CollisionMap();

    //checks for collision with map
    CheckCollision();

    //moves the player
    PlayerMovement();

    //displays the player
    player.display();

    //displays all dots
    DisplayAllDots();

    //deletes dots if pacman eats it
    EatDot();


    //for debugging
    //println(mouseX, mouseY);
    
    //if there are no dots left, the player has won
    if(dots.size() == 0 && powerDots.size() == 0){
      GameOver();
    }
  }

  void GameOver() {
    //resets the player back to the beginning
    player.x = width/2;
    player.y = height/2 + 14;
    
    //resets ghosts
    for (int i = 0; i < theGhosts.length; i++) {
      theGhosts[i].GetEaten();
    }
  
  //sets up dots  
  //rows
  for (int i = 126; i < colMapImage.width; i+= 32) {
    //columns
    for (int j = 30; j < colMapImage.height; j+= 32) {
      //if the place is a corridor and not a wall
      if (collisionMap[i][j] == true) {
        //create a dot at that location
        Dots aDot = new Dots(i, j);
        dots.add(aDot);
      }
    }
  }

  //setup power dots
  PowerDots topLeft = new PowerDots(124, 30);
  PowerDots topRight = new PowerDots(509, 30);
  PowerDots botLeft = new PowerDots(125, 414);
  PowerDots botRight = new PowerDots(510, 414);
  powerDots.add(topLeft);
  powerDots.add(topRight);
  powerDots.add(botLeft);
  powerDots.add(botRight);
}