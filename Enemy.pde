class Enemy{
 
  int x;      //data members: variables in object of this class
  int y;
  int imageCounter=0; // used to decide which image to render
  
  PImage [] imgs;  //array of images for animation
  int imgCount = 4;  //constant - amount of imgs in animation

//constructor
  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    
    //declare array of images for animation
    imgs = new PImage[imgCount];  
    for (int i = 0; i<imgCount;i++){
      imgs[i]=loadImage("enemy"+(i+1)+".png");
    }
  }

  void update() {
    this.move();
    this.display();
  }
  //enemy moves towards goal's coords 
  void move() {
    //enemy needs to move towards the goals coords
    if(goal.x<x){
      x-=2;}
    if(goal.x>x){
      x+=2;}
    if(goal.y<y){
      y-=2;}
    if(goal.y>y){
      y+=2;}
  }

  //draw enemy on screen
  void display() {
    imageMode(CENTER); //draw all PImage from centre
    //change the sprite every 20 frames
    image(imgs[imageCounter/20],x,y);
    imageCounter++;
    if(imageCounter>79){
      imageCounter=0;}
    //displayDebug();
  }
}
