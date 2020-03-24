public int squaresX, squaresY, gameState = 0;  // 0 = MainMenu, 1 = SettingsMenu, 2 = Game, 3 = LevelCreator
private MainMenu mm;
private SettingsMenu sm;
private Game game;

public void setup() {
  fullScreen();
  for (int i = 0; i<lines.length; i++) {
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
}

public void mouseClicked() {
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
    // same as above
    break;
  }
}
