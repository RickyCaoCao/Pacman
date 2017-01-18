class Pacman{
  //class vars
  int x, y, speed, size, dx, dy;
  PImage currentImage;
  
  //constructor
  Pacman(){
    x = width/2;
    y = height/2 + 14;
    x = constrain(x, 110, 530);
    speed = 3;
    size = 20;
    currentImage = loadImage("pacman_UP_0.png");
  }
  
  //displays pacman
  void display(){
    image(currentImage, x, y);
  }
  
  void move(){
    x += dx;
    y += dy;
  }
}
