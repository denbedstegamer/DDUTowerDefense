import processing.sound.*;
SoundFile mainMenu, magicShoot, arrowShoot, bladeSwing, rockThrow, death, victory;

public int squaresX, squaresY, gameState = 0;  // 0 = MainMenu, 1 = SettingsMenu, 2 = Game, 3 = LevelCreator, 4 = LevelSelectionMenu
private MainMenu mm;
private SettingsMenu sm;
private Game game;
private LevelCreator lc;
private LevelSelectionMenu lsm;

public void setup() {
  fullScreen();
  frameRate(60);

  victory = new SoundFile(this, dataPath("") + "/Sound/win_screen.aiff");
  death = new SoundFile(this, dataPath("") + "/Sound/death_screen.aiff");
  rockThrow = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/rocks_hit.aiff");
  magicShoot = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/magicShoot_1.aiff");
  arrowShoot = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/arrowShoot_1.aiff");
  bladeSwing = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/bladeSwing_1.aiff");
  mainMenu = new SoundFile(this, dataPath("") + "/Sound/Medieval.aiff");

  squaresX = 1000;
  squaresY = 700;

  mm = new MainMenu();
}

public void draw() {
  switch(gameState) {
  case 0:
    mm.update();
    mm.render();
    if(!mainMenu.isPlaying()){
      mainMenu.loop();
    }
    break;

  case 1:
    sm.update();
    sm.render();
    break;

  case 2:
    if (game != null) {
      game.update();
      if (game != null) {
        game.render();
      }
    }
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
}

public void mousePressed() {
  switch(gameState) {

  case 2:
    // same as above
    game.mouseEvent(mouseX, mouseY);
    break;

  case 3:
    lc.clickEvent();
    break;
  }
}

public void stopAllMusic() {
  mainMenu.stop();
}

public void attackSound(int id) {
  switch(id) {
    //peasant
  case 1:
    if(!rockThrow.isPlaying()){
      rockThrow.play();
    }
    break;

    //arrows
  case 2:
  case 5:
  case 6:
    if(!arrowShoot.isPlaying()){
      arrowShoot.play();
    }
    break;

    //swords
  case 3:
  case 7:
  case 8:
    if(!bladeSwing.isPlaying()){
      bladeSwing.play();
    }
    break;

    //magic
  case 4:
  case 9:
  case 10:
    if(!magicShoot.isPlaying()){
      magicShoot.play();
    }
    break;
  }
}
