public class Obstacle{
  float x,y,dx,dy;  //ball variables
  PImage img;
  
  Obstacle(int x,int y, int dx, int dy){
    this.x = x;
    this.y=y;
    this.dx=dx;
    this.dy=dy;
    img=loadImage("obstacle1.png");
  }
  
  
  void display(){
    imageMode(CENTER); //draw all PImage from centre
    
    //change the sprite every 20 frames
    image(img,x,y); 
    
    x+=dx;
    y+=dy;
    if(x>=width-10||x<=10){
      dx=-dx;
    }
    if(y>=height-10||y<=10){
      dy=-dy;
    }  
  }
    
  void bouncingObstacle(){
    x+=dx;
    y+=dy;
    if(x>=width-10||x<=10){
      dx=-dx;
    }
    if(y>=height-10||y<=10){
      dy=-dy;
    }  
  }
  
  boolean crash() {
    //return the result of checking if the enemy has hit the goal (true or false)
    return dist(this.x, this.y,  mouseX,mouseY) < img.height;
  }
}
