//vars for storing sprite images and display
PImage [] playerLeft = new PImage[3];
PImage [] playerRight = new PImage[3];
PImage [] playerUp = new PImage[3];
PImage [] playerDown = new PImage[3];
int imageNumber;

float movementTimer = 0;

boolean moveUp = false;
boolean moveDown = false;
;
boolean moveLeft = false;
boolean moveRight = false;

String pressedKey = "";

//void keyPressed() {
//  if (keyCode == UP || key == 'w' || key == 'W'){
//    pressedKey = "UP";
//  }
//  if (keyCode == DOWN || key == 's' || key == 'S') {
//    pressedKey = "DOWN";  
//  }
//  if (keyCode == LEFT || key == 'a' || key == 'A') {
//    pressedKey = "LEFT";
//  }
//  if (keyCode == RIGHT || key == 'd' || key == 'D') {
//    pressedKey = "RIGHT";
//  }
//}

//void keyReleased(){
//  if (keyCode == UP || key == 'w' || key == 'W'){
//    moveUp = false;
//  }
//  if (keyCode == DOWN || key == 's' || key == 'S') {
//    moveDown = false;  
//  }
//  if (keyCode == LEFT || key == 'a' || key == 'A') {
//    moveLeft = false;
//  }
//  if (keyCode == RIGHT || key == 'd' || key == 'D') {
//    moveRight = false;
//  }
//}

void CheckCollision() {
  //variables to check for collision against walls
  boolean top_left = collisionMap[player.x - (player.size)/2][player.y - player.speed - (player.size)/2 - 3];
  boolean top_middle = collisionMap[player.x][player.y - player.speed - (player.size)/2 - 3];
  boolean top_right = collisionMap[player.x + (player.size)/2][player.y - player.speed - (player.size)/2 - 3];
  boolean bottom_left = collisionMap[player.x - (player.size)/2][player.y + player.speed + (player.size)/2 + 3];
  boolean bottom_middle = collisionMap[player.x][player.y + player.speed + (player.size)/2 + 3];
  boolean bottom_right = collisionMap[player.x + (player.size)/2][player.y + player.speed + (player.size)/2 + 3];
  boolean left_up = collisionMap[player.x - player.speed - (player.size)/2 - 3][player.y - (player.size)/2];
  boolean left_middle = collisionMap[player.x - player.speed - (player.size)/2 - 3][player.y];
  boolean left_down = collisionMap[player.x - player.speed - (player.size)/2 - 3][player.y + (player.size)/2];
  boolean right_up = collisionMap[player.x + player.speed + (player.size)/2 + 3][player.y - (player.size)/2];
  boolean right_middle = collisionMap[player.x + player.speed + (player.size)/2 + 3][player.y];
  boolean right_down = collisionMap[player.x + player.speed + (player.size)/2 + 3][player.y + (player.size)/2];

  //The direction can be chosen only if it is clear of walls
  if (keyCode == UP || key == 'w' || key == 'W') {
    if (top_left && top_middle && top_right) {
      pressedKey = "UP";
    }
  } else if (keyCode == DOWN || key == 's' || key == 'S') {
    if (bottom_left && bottom_middle && bottom_right) {
      pressedKey = "DOWN";
    }
  } else if (keyCode == LEFT || key == 'a' || key == 'A') {
    if (left_up && left_middle && left_down) {
      pressedKey = "LEFT";
    }
  } else if (keyCode == RIGHT || key == 'd' || key == 'D') {
    if (right_up && right_middle && right_down) {
      pressedKey = "RIGHT";
    }
  }

  //stops movement when hits wall
  if (pressedKey == "UP") {
    if (!(top_left && top_middle && top_right)) {
      pressedKey = "";
    }
  } else if (pressedKey == "DOWN") {
    if (!(bottom_left && bottom_middle && bottom_right)) {
      pressedKey = "";
    }
  } else if (pressedKey == "LEFT") {
    if (!(left_up && left_middle && left_down)) {
      pressedKey = "";
    }
  } else if (pressedKey == "RIGHT") {
    if (!(right_up && right_middle && right_down)) {
      pressedKey = "";
    }
  }
}

//cycles through the images for Pacman, based off a timer
//also moves Pacman
void PlayerMovement() {
if(millis()-movementTimer >50){
  imageNumber++;
  movementTimer = millis();
  if (imageNumber == 2) {
     imageNumber = 0;
  }
}

  if (pressedKey == "UP") {
    //cycles through images
    player.currentImage = playerUp[imageNumber];
    //moves Pacman
    player.y -= player.speed;
  } else if (pressedKey == "DOWN") {
    player.y += player.speed;
    player.currentImage = playerDown[imageNumber];
  } else if (pressedKey == "LEFT") {
    player.x -= player.speed;
    player.currentImage = playerLeft[imageNumber];

    //teleports the player to the other side through the side portal
    if (player.x <= 114) {
      player.x = 523;
    }
  } else if (pressedKey == "RIGHT") {
    player.x += player.speed;
    player.currentImage = playerRight[imageNumber];

    if (player.x >= 523) {
      player.x = 115;
    }
  }
}

//previous code, feel free to ignore
  //  boolean 
  //  boolean up_left = false;
  //  boolean up_right = false;
  //  boolean down_right = false;
  //  boolean down_left = false;
  //  boolean up_middle = false;
  //  boolean down_middle = false;
  //  boolean left_middle = false;
  //  boolean right_middle = false;
  //
  //  //loops through the images
  //  imageNumber++;
  //  if (imageNumber == 2) {
  //    imageNumber = 0;
  //  }
  //
  //
  //  if (p) {
  //    //checks if the pacman can fit at each of the four edges and four corners
  //    up_left = collisionMap[player.x - (player.size)/2][player.y - player.speed - (player.size)/2];
  //    up_right = collisionMap[player.x + (player.size)/2][player.y - player.speed - (player.size)/2];
  //    down_right = collisionMap[player.x + (player.size)/2][player.y - player.speed + (player.size)/2];
  //    down_left = collisionMap[player.x - (player.size)/2][player.y - player.speed + (player.size)/2];
  //    up_middle = collisionMap[player.x][player.y - player.speed - (player.size)/2];
  //
  //    //if all conditions satisfy...
  //    if (up_left && up_right && down_right && down_left && up_middle) {
  //      //... it will move and change image
  //      player.dy = -player.speed;
  //      player.currentImage = playerUp[imageNumber];
  //      println("up");
  //    }
  //  }
  //
  //
  //  //this procedure is repeated for all four directions
  //  if (moveDown) {
  //    up_left = collisionMap[player.x - (player.size)/2][player.y + player.speed - (player.size)/2];
  //    up_right = collisionMap[player.x + (player.size)/2][player.y + player.speed - (player.size)/2];
  //    down_right = collisionMap[player.x + (player.size)/2][player.y + player.speed + (player.size)/2];
  //    down_left = collisionMap[player.x - (player.size)/2][player.y + player.speed + (player.size)/2];
  //    down_middle = collisionMap[player.x][player.y + player.speed + (player.size)/2];
  //
  //    if (up_left && up_right && down_right && down_left && down_middle) {
  //      player.dy = player.speed;
  //      player.currentImage = playerDown[imageNumber];
  //      println("down");
  //    }
  //  }
  //
  //  if (moveLeft) {
  //    up_left = collisionMap[player.x - player.speed - (player.size)/2][player.y - (player.size)/2];
  //    up_right = collisionMap[player.x - player.speed + (player.size)/2][player.y - (player.size)/2];
  //    down_right = collisionMap[player.x - player.speed + (player.size)/2][player.y + (player.size)/2];
  //    down_left = collisionMap[player.x - player.speed - (player.size)/2][player.y + (player.size)/2];
  //    left_middle = collisionMap[player.x - player.speed - (player.size)/2][player.y];
  //
  //    if (up_left && up_right && down_right && down_left && left_middle) {
  //      player.dx = -player.speed;
  //      println("left");
  //      player.currentImage = playerLeft[imageNumber];
  //    }
  //
  //    //teleports the player to the other side through the side portal
  //    if (player.x <= 115) {
  //      player.x = 523;
  //    }
  //  }
  //
  //  if (moveRight) {
  //    up_left = collisionMap[player.x + player.speed - (player.size)/2][player.y - (player.size)/2];
  //    up_right = collisionMap[player.x + player.speed + (player.size)/2][player.y - (player.size)/2];
  //    down_right = collisionMap[player.x + player.speed + (player.size)/2][player.y + (player.size)/2];
  //    down_left = collisionMap[player.x + player.speed - (player.size)/2][player.y + (player.size)/2];
  //    right_middle = collisionMap[player.x + player.speed + (player.size)/2][player.y];
  //
  //    if (up_left && up_right && down_right && down_left && right_middle) {
  //      player.dx = player.speed;
  //      player.currentImage = playerRight[imageNumber];
  //      println("right");
  //    }
  //
  //    if (player.x >= 523) {
  //      player.x = 115;
  //    }
  //  }
  //
  //  player.move();
  //}