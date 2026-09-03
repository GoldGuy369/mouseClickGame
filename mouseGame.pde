ArrayList<Enemy> enemies;
int maxEnemies = 5;
Obstacle obstacle1;
Block block1;
Goal goal;
PImage backGround;
PImage gameOver;
PImage mouse;
int bgX = 0;
int score=0;

//hish score system
String [] lines;
int [] numbers; //where to allocate memory?

//constants to represent state of the game
//final means value cannot change
final int PLAYING = 0;
final int FINISHED = 1;
int gameMode = PLAYING; //but the state of 'playing' can change

void setup() {
  size(800, 500);
  backGround = loadImage("bg.png");
  backGround.resize(width, height);
  
  //enemy arr initialisation
  enemies = new ArrayList<Enemy>();
  //add an enemy to list, spwaning at a random x at the top of the screen.
  for(int i=0;i<2;i++){
    enemies.add(new Enemy((int)random(width),0));
  }
  
  goal = new Goal(400,400,3);
  obstacle1 =new Obstacle(50,10,1,5);
  block1 =new Block(100,10,3,5,3);
  mouse = loadImage("mouse.png");
  
  
  //HIGH SCORE SYSTEM INITIALISATION
  lines = loadStrings("data/numbers.txt");  //use the number of lines of strings to get length of array needed
  numbers = new int[lines.length]; //create array of ints same size as lines

  //for each string in strings - convert to int and store in numbers array
  for (int i=0; i<lines.length; i++) { //Converting string array to int array
    numbers[i] = Integer.valueOf(lines[i]);
  }
}

void draw() {
  if (gameMode == PLAYING) {
    maxEnemies=(score/5)+3;
    showBackground();
    spawnEnemy();
    //Update and display enemies, backwards iteration to prevent index errors
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy currentEnemy = enemies.get(i);    //select current enemy from backwards linear search
      currentEnemy.update();  //display enemy
    }

    goal.display();
    obstacle1.display();
    block1.display();
    image(mouse,mouseX,mouseY);
    //detect when enemy reaches goal
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy currentEnemy = enemies.get(i);
      if (goal.crash(currentEnemy)) {
        println("crash!!");
        goal.health-=1;
        enemies.remove(i);  //remove enemy from array 
        enemies.add(new Enemy((int)random(width),0));  //spawn new enemy
        println("crash!! Health:" + goal.health);
        //end game when goal hp==0
      }
    }
    
    //obstacle collision with mouse
    if(dist(obstacle1.x, obstacle1.y, mouseX,mouseY) <50){
      goal.health-=1;
      println("obCrash");
      obstacle1.x=20;
      obstacle1.y=20;
    }
    if(dist(block1.x, block1.y, mouseX,mouseY) <50){
      goal.health-=block1.dmg;
      println("obCrash");
      block1.x=20;
      block1.y=20;
    }
    //GAMEOVER
    if (goal.health<=0){
      //display game over screen
      println("Gameover");
      gameOver = loadImage("gameOver.png");
      gameOver.resize(width, height);
      imageMode(CORNER); //draw background from top left
      image(gameOver, 0, 0);
      textSize(68);
      text(score, 580, 175);
      
      //highscore updates
      numbers = insert(score, numbers);  //insert score into numbers and replace numbers with the new array
      
      lines = new String[numbers.length];
      for (int j=0; j<numbers.length; j++) { //converting int array to strings
        lines[j] = String.valueOf(numbers[j]);
      }
      //keep the array a fixed size
      int maxScores = 5;
      if (numbers.length > maxScores) {
        int[] trimmed = new int[maxScores];
        for (int j=0; j<maxScores; j++) {
          trimmed[j] = numbers[j];
          println(numbers[j]);    //display scores
        }
        numbers = trimmed;
      }
    
      // convert back to String[] for saving
      lines = new String[numbers.length];
      //display highscores on game over screen
      for (int j = 0; j < numbers.length; j++) {
        lines[j] = str(numbers[j]);
        textSize(30);
        text((j + 1) + ". " + numbers[j], 575, 350 + j * 30);
      }
      saveStrings("data/numbers.txt",lines);    //update file with new scores
      
      
      gameMode=FINISHED;    //stops the game and the background updating to stay on death screen
    }
  }
}

 
void showBackground()
{
  imageMode(CORNER); //draw background from top left
  image(backGround, bgX, 0); //draw background
  textSize(32);
  text("score:", 50, 420);
  text(score, 80, 450);
  text("health:", 680, 420);
  text(goal.health, 720, 450);
}

//check if enemy is in coords of mouse (true/false)
boolean kill(Enemy enemy) {
  return dist(mouseX, mouseY,  enemy.x, enemy.y) < 50;
}

//add enemy to list if score is multiple of 5 and theres is less enemies than the max allowed
void spawnEnemy(){
  if (score % 5 ==0 && score>0 && enemies.size()<maxEnemies){
    enemies.add(new Enemy((int)random(width),0));
  }
}


//remove enemy and add one point if enemy within mouseclick
void mouseClicked(){
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy currentEnemy = enemies.get(i);
    if(kill(currentEnemy)){
      score++;
      enemies.remove(i);
      println("Enemy " + i + " : killed");
      enemies.add(new Enemy((int)random(width),0));  //spwan new enemy
    }
  }
}

//HIGH SCORE SYSTEM
//returns new array of ints for high score system
int[] insert(int toInsert, int[] array) {
  int[] result = new int[array.length + 1];
  boolean inserted = false;  //boolean flag
  int position=0;  // index for result[]
  
  //linear search to find where the new number should go
  //binary search would be more efficient for larger data sets
  for (int i=0; i<array.length; i++) {
    //If we haven't inserted yet and this is the correct place:
    if (!inserted && toInsert >= array[i]) {
      result[position++] = toInsert;
      inserted = true;
    }
    result[position++] = array[i];
  }
  
  //If it's the largest number, insert at the end
  if (!inserted) {
    result[result.length - 1] = toInsert;
  }
  return result;
}



/*
REFERENCES
https://processing.org/reference/text_.html    used 24/11 to see how to display text and change size




*/
