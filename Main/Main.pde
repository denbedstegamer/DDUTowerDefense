public int squaresX, squaresY, gameState = 0;  // 0 = MainMenu, 1 = SettingsMenu, 2 = Game, 3 = LevelCreator
private MainMenu mm;
private SettingsMenu sm;
private Game game;
private LevelCreator lc;

public void setup() {
  fullScreen();
  frameRate(60);
  
  /*
  String[] lines = loadStrings("field1.txt");
  for (int i = 0; i<lines.length; i++) {
    println(lines[i]);
  }
  */

  squaresX = 1000;
  squaresY = 700;

  mm = new MainMenu();
}

public void draw() {
  switch(gameState) {
  case 0:
    mm.update();
    mm.render();
    break;

  case 1:
    sm.update();
    sm.render();
    break;

  case 2:
    game.update();
    game.render();
    break;
    
  case 3:
    lc.update();
    lc.render();
    break;
  }
  fill(0);
  //text(frameRate, width/10, height-height/15);
}

public void mousePressed() {
  switch(gameState) {
  case 0:
    //mm.clickEvent();
    break;

  case 1:
    // same as above
    break;

  case 2:
    // same as above
    game.mouseEvent(mouseX, mouseY);
    break;
    
  case 3:
    lc.clickEvent();
    break;
  }
}
