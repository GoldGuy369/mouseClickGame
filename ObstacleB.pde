//inherit from obstacle but change some attributes
class Block extends Obstacle{
  int dmg;
  
  Block(int x,int y, int dx, int dy, int dmg){
    super(x,y,dx,dy);
    this.dmg=dmg;
    img=loadImage("block.png");
  }
}
