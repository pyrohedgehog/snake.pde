class Player {
  
   PFont font; 

  // snake class has the players information
  
  void displayPlayer() {
    font = loadFont("bitwonder.vlw"); 
    fill(255);
    textFont(font, 14);
    text("Player 1",430,30);
  }
}