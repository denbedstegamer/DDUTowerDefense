import processing.sound.*;
SoundFile mainMenuMusic, magicShoot, arrowShoot, bladeSwing, rockThrow, death, victory, buttonClick, ingameMusic;

public int squaresX, squaresY, gameState = 0;  // 0 = MainMenu, 1 = SettingsMenu, 2 = Game, 3 = LevelCreator, 4 = LevelSelectionMenu
private MainMenu mm;
private SettingsMenu sm;
private Game game;
private LevelCreator lc;
private LevelSelectionMenu lsm;

public void setup() {
  fullScreen();
  frameRate(60);

  ingameMusic = new SoundFile(this, dataPath("") + "/Sound/glorious_morning.aiff");
  victory = new SoundFile(this, dataPath("") + "/Sound/win_screen.aiff");
  death = new SoundFile(this, dataPath("") + "/Sound/death_screen.aiff");
  rockThrow = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/rocks_hit.aiff");
  magicShoot = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/magicShoot_1.aiff");
  arrowShoot = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/arrowShoot_1.aiff");
  bladeSwing = new SoundFile(this, dataPath("") + "/Sound/AttackSounds/bladeSwing_1.aiff");
  mainMenuMusic = new SoundFile(this, dataPath("") + "/Sound/Medieval.aiff");
  buttonClick = new SoundFile(this, dataPath("") + "/Sound/button_click.aiff");

  squaresX = 1000;
  squaresY = 700;

  mm = new MainMenu();
}

public void draw() {
  switch(gameState) {
  case 0:
    mm.update();
    mm.render();
    if (!mainMenuMusic.isPlaying()) {
      mainMenuMusic.amp(0.2);
      mainMenuMusic.loop();
    }
    noOverlappingMusic();
    break;

  case 1:
    sm.update();
    sm.render();
    noOverlappingMusic();
    break;

  case 2:
    if (!ingameMusic.isPlaying()) {
      ingameMusic.amp(0.2);
      ingameMusic.loop();
    }
    if (game != null) {
      game.update();
      if (game != null) {
        game.render();
      }
    }
    noOverlappingMusic();
    break;

  case 3:
    lc.update();
    lc.render();
    noOverlappingMusic();
    break;

  case 4:
    lsm.update();
    lsm.render();
    noOverlappingMusic();
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
  mainMenuMusic.stop();
  ingameMusic.stop();
}

public void noOverlappingMusic() {
  switch(gameState) {
  case 0:
  if (ingameMusic.isPlaying()) {
    ingameMusic.stop();
  }
    break;

  case 1:
  if (ingameMusic.isPlaying()) {
    ingameMusic.stop();
  }
    break;

  case 2:
  if (mainMenuMusic.isPlaying()) {
    mainMenuMusic.stop();
  }
    break;

  case 3:
  if (ingameMusic.isPlaying()) {
    ingameMusic.stop();
  }
    break;

  case 4:
  if (ingameMusic.isPlaying()) {
    ingameMusic.stop();
  }
    break;
  }
}

public void attackSound(int id) {
  switch(id) {
    //peasant
  case 1:
    if (!rockThrow.isPlaying()) {
      rockThrow.play();
    }
    break;

    //arrows
  case 2:
  case 5:
  case 6:
    if (!arrowShoot.isPlaying()) {
      arrowShoot.play();
    }
    break;

    //swords
  case 3:
  case 7:
  case 8:
    if (!bladeSwing.isPlaying()) {
      bladeSwing.play();
    }
    break;

    //magic
  case 4:
  case 9:
  case 10:
    if (!magicShoot.isPlaying()) {
      magicShoot.play();
    }
    break;
  }
}
