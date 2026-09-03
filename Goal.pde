class Goal{
  
  int x,y,health;
  
  PImage img;
  //constructor with basic variables needed
  Goal(int x, int y, int health){
    this.x=x;
    this.y=y;
    this.health=health;
    
    img=loadImage("goal.png");  //image of goal that will be shown
  }
  
  
  void display(){
    //draw goal on screen for enemies to move towards
    image(img,x,y);
  }

  boolean crash(Enemy enemy) {
    // return the result of checking if the enemy has hit the goal (true or false)
    return dist(this.x, this.y,  enemy.x, enemy.y) < img.height;
  }
}
