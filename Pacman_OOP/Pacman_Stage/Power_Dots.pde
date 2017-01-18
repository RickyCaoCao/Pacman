//variables to store if PacMan is frenzied
boolean frenzied = false;
float frenzyTimer = 0;


class PowerDots extends Dots{
  //constructor
  PowerDots(int xcoord, int ycoord){
    super(xcoord, ycoord);
    size = 8;
  }
  
  //display pink, power dot
  void display(){
    noStroke();
    fill(255, 5, 214); //pink
    ellipse(x,y,size,size);
  }
}

void GainPower(){  
  //creates a new list of elements in dots needed to be removed
  ArrayList <PowerDots> toRemove = new ArrayList <PowerDots>();
  
  for(PowerDots item: powerDots){
    //if player collides with power dot
    if ((item.x + 10) > (player.x - 10) && (item.y + 10) > (player.y - 10) && (player.x + 10) > (item.x - 10) && (player.y + 10) > (item.y - 10)){
      //add item to the remove list
      toRemove.add(item);
      //goes into frenzy
      frenzied = true;
      frenzyTimer = millis();
    }
  }
  
  //remove dots that collided with pacman from the arraylist
  for(PowerDots item: toRemove){
    powerDots.remove(item);
  }
}

//void FrenzyMode(){
//  for(int i = 0; i < theGhosts.length; i++){
//    //if a ghost collides
//    if ((item.x + 10) > (player.x - 10) && (item.y + 10) > (player.y - 10) && (player.x + 10) > (item.x - 10) && (player.y + 10) > (item.y - 10)){
//      //add item to the remove list
//      toRemove.add(item);
//      //goes into frenzy
//      frenzied = true;
//      frenzyTimer = millis();
//    }
//  }
//}
