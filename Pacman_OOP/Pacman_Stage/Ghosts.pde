class Ghost {
  //class vars
  float timer;
  int x, y, speed, size, startPos, direction, newDirection, bufferSpace;
  PImage [] ghostImage = new PImage [2];
  boolean outOfPen = false;
  
  //constructor
  Ghost(int _x, int _y, int _startPos, int _speed) {
    x = _x;
    y = _y;
    size = 20;
    speed = _speed;
    startPos = _startPos;
    timer = 0;
    bufferSpace = 4;
  }

  void display() {
    //will display normal picture if Pacman not in frenzy mode
    if(!frenzied){
      image(ghostImage[0], x ,y);
    }
    //displays the "scared" ghost sprite
    else{
      //flashes at the end to signal the frenzy phase is almost over
      if(millis() - frenzyTimer > 1750){
        if((millis() - frenzyTimer) % 150 <= 75){
          fill(0);
          ellipse(x, y, size, size);
        }
        else{
          image(ghostImage[1], x, y);
        }
      } 
      else{
        image(ghostImage[1], x, y);
      }
      
    }
    
  }

  //gets ghosts to leave their pen after reset and after getting eaten by Pacman
  void leavePen() {
    //left ghost
    if (startPos == 0) {
      if (millis() - timer > 2500) {
        if (x<320) {
          x++; //move right
        } else if (y > 170) {
          y--; //move up
        } else {
          outOfPen = true;
          direction = 1;
        }
      }
    } 
    //middle ghost
    else if (startPos == 1) {
      if (millis() - timer > 1000) {
        if (y > 170) {
          y--;
        } else {
          outOfPen = true;
          direction = 3;
        }
      }
    }
    //right ghost
    else if (startPos == 2) {
      if (millis() - timer > 4000) {
        if (x>320) {
          x--; //move left
        } else if (y > 170) {
          y--; //move up
        } else {
          outOfPen = true;
          direction = 3;
        }
      }
    }
  }

  //Each ghost decides to turn left or right, in respective to their current direction
  void DetermineDirection(){
      float chance = random(-1,1);
      if(chance < 0){
        if(direction>0){
          newDirection = direction - 1;
        }
        else{
          newDirection = 3;
        }
      }
      else{
        if(direction < 3){
          newDirection = direction + 1;
        }
        else{
          newDirection = 0;
        }
      }
  }

  void Wander() {
    //variables to check for collision
    boolean top_left = collisionMap[x - (size)/2][y - speed - (size)/2 - bufferSpace];
    boolean top_middle = collisionMap[x][y - speed - (size)/2 - bufferSpace];
    boolean top_right = collisionMap[x + (size)/2][y - speed - (size)/2 - bufferSpace];
    boolean right_up = collisionMap[x + speed + (size)/2 + bufferSpace][y - (size)/2];
    boolean right_middle = collisionMap[x + speed + (size)/2 + bufferSpace][y];
    boolean right_down = collisionMap[x + speed + (size)/2 + bufferSpace][y + (size)/2];
    boolean bottom_left = collisionMap[x - (size)/2][y + speed + (size)/2 + bufferSpace];
    boolean bottom_middle = collisionMap[x][y + speed + (size)/2 + bufferSpace];
    boolean bottom_right = collisionMap[x + (size)/2][y + speed + (size)/2 + bufferSpace];
    boolean left_up = collisionMap[x - speed - (size)/2 - bufferSpace][y - (size)/2];
    boolean left_middle = collisionMap[x - speed - (size)/2 - bufferSpace][y];
    boolean left_down = collisionMap[x - speed - (size)/2 - bufferSpace][y + (size)/2];
    
    //if the ghost will not touch wall, continue moving 
    if(direction == 0){
      if(top_left && top_middle && top_right){
        y -= speed;
      }
      //if the ghost hits a wall, the ghost will decide to turn left or right
      else{
        DetermineDirection();
      }      
    }
    else if(direction == 1){
      if(right_up && right_middle && right_down){
        x += speed;
      }
      else{
        DetermineDirection();
      }
    }
    else if(direction == 2){
      if(bottom_left && bottom_middle && bottom_right){
        y += speed;
      }
      else{
        DetermineDirection();
      }
    }
    else if(direction == 3){
      if(left_up && left_middle && left_down){
        x -= speed;
      }
      else{
        DetermineDirection();
      }
    }
    else{
      println("ERROR");
    }
    
    //will change direction if it won't run into a wall immediately
    if(newDirection == 0){
      if(top_left && top_middle && top_right){
        direction = 0;
      }
    }
    
    else if(newDirection == 1){
      if(right_up && right_middle && right_down){
        direction = 1;
      }
    }
    else if(newDirection == 2){
      if(bottom_left && bottom_middle && bottom_right){
        direction = 2;
      }
    }
    else if(newDirection == 3){
      if(left_up && left_middle && left_down){
        direction = 3;
      }
    }
    else{
      println("ERROR!");
    }
    
  }

  //occurs when frenzied Pacman eats a ghost
  void GetEaten() {
    //resets timer to determine when the ghost gets out
    timer = millis();
    //ghost is put back into the pen
    if (startPos == 0) {
      x = 287;
      y = 213;
    } else if (startPos == 1) {
      x = 320;
      y = 213;
    } else if (startPos == 2) {
      x = 352;
      y = 213;
    }
    outOfPen = false;
  }
}