class Score {
  
 PFont font; 
 
  void loadScoreBoard(){
    font = loadFont("bitwonder.vlw"); 
    fill(255);
    textFont(font, 14);
    text("Score:"+str(snakesize-1)+"",70,30);
  }
}