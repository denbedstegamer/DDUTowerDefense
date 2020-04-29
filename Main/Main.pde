import processing.sound.*;
SoundFile file;

public int squaresX, squaresY, gameState = 0;  // 0 = MainMenu, 1 = SettingsMenu, 2 = Game, 3 = LevelCreator, 4 = LevelSelectionMenu
private MainMenu mm;
private SettingsMenu sm;
private Game game;
private LevelCreator lc;
private LevelSelectionMenu lsm;

public void setup() {
  fullScreen();
  frameRate(60);
  
  file = new SoundFile(this, dataPath("") + "/Sound/Medieval.aiff");
  file.play();
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
    
  case 4:
    lsm.update();
    lsm.render();
    break;
  }
  fill(0);
  textAlign(LEFT);
  textSize(14);
  text("fps: "+frameRate, width/128, height-height/64);
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
