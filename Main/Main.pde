import processing.sound.*;
SoundFile mainMenu, magicShoot, arrowShoot, bladeSwing, rockThrow, death;

public int squaresX, squaresY, gameState = 0;  // 0 = MainMenu, 1 = SettingsMenu, 2 = Game, 3 = LevelCreator, 4 = LevelSelectionMenu
private MainMenu mm;
private SettingsMenu sm;
private Game game;
private LevelCreator lc;
private LevelSelectionMenu lsm;
private boolean mainMenuSound, noArrowSound, noMagicSound, noBladeSound, noRockSound;

public void setup() {
  fullScreen();
  frameRate(60);

  death = new SoundFile(this, dataPath("") + "/Sound/death_screen.aiff");
  rockThrow = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/rocks_hit.aiff");
  magicShoot = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/magicShoot_1.aiff");
  arrowShoot = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/arrowShoot_1.aiff");
  bladeSwing = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/bladeSwing_1.aiff");
  mainMenu = new SoundFile(this, dataPath("") + "/Sound/Medieval.aiff");

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
  setMusicBooleans();
  switch(gameState) {
  case 0:
    mm.update();
    mm.render();
    if (!mainMenuSound) {
      mainMenu.loop();
      mainMenuSound = true;
    }
    break;

  case 1:
    sm.update();
    sm.render();
    break;

  case 2:
    game.update();
    if (game != null) {
      game.render();
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
  stopAllMusic();
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

public void setMusicBooleans() {
  noArrowSound = true;
  noBladeSound = true;
  noMagicSound = true;
  noRockSound = true;
  switch(gameState) {
  case 0:

    break;

  case 1:
    mainMenuSound = false;
    break;

  case 2:
    mainMenuSound = false;
    break;

  case 3:
    mainMenuSound = false;
    break;

  case 4:
    mainMenuSound = false;
    break;
  }
}

public void stopAllMusic() {
  if (!mainMenuSound) {
    mainMenu.stop();
  }
}

public void attackSound(int id) {
  switch(id) {
    //peasant
  case 1:
    if (noRockSound) {
      rockThrow.play();
      noRockSound = false;
    }
    break;

    //arrows
  case 2:
  case 5:
  case 6:
    if (noArrowSound) {
      arrowShoot.play();
      noArrowSound = false;
    }
    break;

    //swords
  case 3:
  case 7:
  case 8:
    if (noBladeSound) {
      bladeSwing.play();
      noBladeSound = false;
    }
    break;

    //magic
  case 4:
  case 9:
  case 10:
    if (noMagicSound) {
      magicShoot.play();
      noMagicSound = false;
    }
    break;
  }
}
