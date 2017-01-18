//reads collision map using color
//code idea and image credit to Laurel Deel

//2-dimensional array for the collision map
boolean [][] collisionMap;

void CollisionMap(){
  collisionMap = new boolean[colMapImage.width][colMapImage.height];
  color black = color(0);
  color white = color(255);
  
  //goes through the image by rows and columns
  //rows
  for(int i = 0; i < colMapImage.width; i++){
    //columns
    for(int j = 0; j < colMapImage.height; j++){
      //gets color at certain location from image
      color c = colMapImage.get(i, j);
      
      //black are walls
      if(c == black){
        collisionMap[i][j] = false;
      }
      
      //white are passages
      else if (c == white){
        collisionMap[i][j] = true;
      }
    }
  }
}