//Modern Snake -- a game developed by Liam Maheu
//music by Anamanaguchi
//This game runs on Processing :-)

import ddf.minim.*;


int angle=0;
int snakesize=5;
int time=0;
int[] headx= new int [2500];
int[] heady= new int [2500];
int applex=(round(random(47))+1)*8;
int appley=(round(random(47))+1)*8;
boolean redo=true;
boolean stopgame=false;
Minim minim;
AudioPlayer song;

void setup ()
{
  size(500, 500);
  textAlign(CENTER);
  background(255);

  minim = new Minim(this);
  song = minim.loadFile("15.mp3");
  song.play();
    restart();



}

void draw()
{
  if (stopgame)
  {
    //do nothing because of game over (stop playing)
  } else
  {
    time+=1;
    fill(155, 0, 0);
    stroke(0);
    rect(applex, appley, 8, 8);
    fill(0);
    stroke(0);
    rect(0, 0, width, 8);
    rect(0, height-8, width, 8);
    rect(0, 0, 8, height);
    rect(width-8, 0, 8, height);

    if ((time % 3)==0)
    {
      travel();
      display();
      if(checkdead()){
  
        PFont font;
        font = loadFont("bitwonder.vlw");//this font doesnt work for me, but if it does for you...
        for (int i=2; i<=snakesize; i++)
        fill(255);
        textFont(font, 50);
        text("GAME OVER", 250, 250);
        fill(255);
        textFont(font, 12.5);
        text("PRESS SHIFT TO TRY AGAIN", 250, 270);
        stopgame=true;
        //score class #1
        Score score = new Score();
        score.loadScoreBoard();

        // display player information #1
        Player player = new Player();
        player.displayPlayer();
      }
    }
  }
}

//controls:
void keyPressed()
{
  if (key == CODED)
  {
    //steers the snake a full 360 degrees based on the arrow keys pressed in 90 degree increments.
    if (keyCode == UP && angle!=270 && (heady[1]-8)!=heady[2])
    {
      angle=90;
    }
    if (keyCode == DOWN && angle!=90 && (heady[1]+8)!=heady[2])
    {
      angle=270;
    }
    if (keyCode == LEFT && angle!=0 && (headx[1]-8)!=headx[2])
    {
      angle=180;
    }
    if (keyCode == RIGHT && angle!=180 && (headx[1]+8)!=headx[2])
    {
      angle=0;
    }
    if (keyCode == SHIFT)
    {
      //restart the game by pressing shift
      restart();
    }
  }
}

// Method for snake movement
void travel()
{
  for (int i=snakesize; i>0; i--)
  {
    if (i!=1)
    {
      //shift all the coordinates back one array
      headx[i]=headx[i-1];
      heady[i]=heady[i-1];
    } else
    {
      //moves the snake head forward in the direction you are steering
      switch(angle)
      {
      case 0:
        headx[1]+=8;
        break;
      case 90:
        heady[1]-=8;
        break;
      case 180:
        headx[1]-=8;
        break;
      case 270:
        heady[1]+=8;
        break;
      }
    }
  }
}

void display()


{
  //is the head of the snake eating the apple?
  if (headx[1]==applex && heady[1]==appley)

  {
    //spawn the apple away from the snake
    snakesize+=round(random(3)+1);
    redo=true;
    while (redo)
    {
      applex=(round(random(47))+1)*8;
      appley=(round(random(47))+1)*8;
      for (int i=1; i<snakesize; i++)
      {

        if (applex==headx[i] && appley==heady[i])
        {
          redo=true;
        } else
        {
          redo=false;
          i=1000;
        }
      }
    }
  }
  //allows the snake movement
  stroke(0, 0, 0);
  fill(0,255,0);
  rect(headx[1], heady[1], 8, 8);
  //...then erase the back end of the snake.
  fill(0,150,0);
  rect(headx[snakesize], heady[snakesize], 8, 8);


}
boolean checkdead(){
  //loading in font for 'Game Over', plus Score class.
  boolean holdie=false;//needed to have 1 return, removing annoying errors
  for (int i=2; i<=snakesize; i++){
    // if the snake eats itself..
    if (headx[1]==headx[i] && heady[1]==heady[i]){
      holdie=true;
    }//if the snake charges into the wall..
    if (headx[1]>=(width-8) || heady[1]>=(height-8) || headx[1]<=0 || heady[1]<=0){
      holdie = true;
    }
  }
  if(holdie) {
     return true; 
    }else{
     return false; 
    }
}
void restart()
{
  // resets all assets to base value
  background(0,0,150);
  headx[1]=200;
  heady[1]=200;
  for (int i=2; i<1000; i++)
  {
    headx[i]=0;
    heady[i]=0;
  }
  stopgame=false;
  applex=(round(random(47))+1)*8;
  appley=(round(random(47))+1)*8;
  snakesize=5;
  time=0;
  angle=0;
  redo=true;

}
