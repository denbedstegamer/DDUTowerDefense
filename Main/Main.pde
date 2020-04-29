import processing.sound.*;
SoundFile mainMenu, magicShoot, arrowShoot, bladeSwing;

public int squaresX, squaresY, gameState = 0;  // 0 = MainMenu, 1 = SettingsMenu, 2 = Game, 3 = LevelCreator, 4 = LevelSelectionMenu
private MainMenu mm;
private SettingsMenu sm;
private Game game;
private LevelCreator lc;
private LevelSelectionMenu lsm;
private boolean mainMenuSound;

public void setup() {
  fullScreen();
  frameRate(60);
  
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
    
      break;

      //archer
    case 2:
    arrowShoot.play();
      break;

      //knight
    case 3:
    bladeSwing();
      break;

      //mage
    case 4:
    
      break;

      //arrowflinger
    case 5:
    
      break;

      //sniper
    case 6:
    
      break;

      //barbarian
    case 7:
    
      break;

      //king
    case 8:
    
      break;

      //summoner
    case 9:
    
      break;

      //archmage
    case 10:
    
      break;
      
      //void summon
    case 11:
    
      break;
    }
}
