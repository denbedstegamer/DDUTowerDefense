public class MainMenu {
  private Button toGame, toSettings, toLevelCreator;

  public MainMenu() {
    toGame = new Button(width/2-width/6, height/4, width/3, height/8, "Play") {
      @Override
        public void action() {
        if (game == null) {
          game = new Game();
        }
        gameState = 2;
      }
    };

    toSettings = new Button(width/2-width/6, height/2-height/24, width/3, height/8, "Settings") {
      @Override
        public void action() {
        sm = new SettingsMenu();
        gameState = 1;
      }
    };

    toLevelCreator = new Button(width/2-width/6, height/2+height/6, width/3, height/8, "Level Creator") {
      @Override
        public void action() {
        if (lc == null) {
          lc = new LevelCreator();
        }
        gameState = 3;
      }
    };
  }

  public void update() {
    toGame.pressed();
    toSettings.pressed();
    toLevelCreator.pressed();
  }

  public void render() {
    background(255);
    toGame.render();
    toSettings.render();
    toLevelCreator.render();
  }
}
