public class MainMenu {
  private Button toGame, toSettings, toLevelCreator, reset;
  private PImage background, background2;
  private boolean hasDrawnBackground;

  public MainMenu() {
    background = loadImage(dataPath("") + "/Backgrounds/MainMenuBackgrounds/MoreSoldiers.jpg");
    toGame = new Button(width/2-width/6, height/4-height/8, width/3, height/8, "Play", "", "") {
      @Override
        public void action() {
        if (game != null) {
          gameState = 2;
        } else {
          if (lsm == null) {
            lsm = new LevelSelectionMenu();
          }
          gameState = 4;
          delay(100);
        }
      }
    };

    toSettings = new Button(width/2-width/6+width/48, height/2-height/6, width/3-width/24, height/8, "Settings", "", "") {
      @Override
        public void action() {
        if (sm == null) {
          sm = new SettingsMenu();
        }
        gameState = 1;
      }
    };

    toLevelCreator = new Button(width/2-width/6+width/48, height/2+height/4, width/3-width/24, height/8, "Level Creator", "", "") {
      @Override
        public void action() {
        if (lc == null) {
          lc = new LevelCreator();
        }
        gameState = 3;
      }
    };
    
    reset = new Button(width/2+width/5, height/4-height/8+height/52, width/10, height/12, "reset", "", "") {
      @Override
        public void action() {
        game = null;
      }
    };
  }

  public void update() {
    toGame.pressed();
    toSettings.pressed();
    toLevelCreator.pressed();
    reset.pressed();
  }

  public void render() {
    background(255);
    if (!hasDrawnBackground) {
      imageMode(CORNER);
      image(background, 0, 0, width, height);
      background2 = get();
      hasDrawnBackground = true;
    }
    background(background2);
    toGame.render();
    toSettings.render();
    toLevelCreator.render();
    reset.render();
  }
}
