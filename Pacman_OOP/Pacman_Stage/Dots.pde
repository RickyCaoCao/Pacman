class Dots{
  //class variables
  float x,y, size;
  
  //constructor
  Dots(int xcoord, int ycoord){
    x = xcoord;
    y = ycoord;
    size = 5;
  }
  
  //displays dots
  void display(){
    noStroke();
    fill(255, 255, 0); //yellow
    ellipse(x,y,size,size);
  }
}

//displays all the dots
void DisplayAllDots(){
  for(Dots item : dots){
    item.display();
  }
  for(PowerDots item: powerDots){
    item.display();
  }
}

void EatDot(){
  //creates a new list of elements in dots needed to be removed
  ArrayList <Dots> toRemove = new ArrayList <Dots>();
  
  for(Dots item: dots){
    //if player collides with dot
    if ((item.x + 10) > (player.x - 10) && (item.y + 10) > (player.y - 10) && (player.x + 10) > (item.x - 10) && (player.y + 10) > (item.y - 10)){
      //add item to the remove list
      toRemove.add(item);
    }
  }
  
  //remove dots that collided with pacman from the arraylist
  for(Dots item: toRemove){
    dots.remove(item);
  }
}
