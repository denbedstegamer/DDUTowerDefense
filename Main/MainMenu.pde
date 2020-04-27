public class MainMenu {
  private Button toGame, toSettings, toLevelCreator;
  private boolean isSelectingFile;

  public MainMenu() {
    toGame = new Button(width/2-width/6, height/4, width/3, height/8, "Play", "", "") {
      @Override
        public void action() {
        if (game == null) {
          if (!isSelectingFile) {
            chooseFile();
          }
        }
        isSelectingFile = true;
      }
    };

    toSettings = new Button(width/2-width/6, height/2-height/24, width/3, height/8, "Settings", "", "") {
      @Override
        public void action() {
        sm = new SettingsMenu();
        gameState = 1;
      }
    };

    toLevelCreator = new Button(width/2-width/6, height/2+height/6, width/3, height/8, "Level Creator", "", "") {
      @Override
        public void action() {
        if (lc == null) {
          lc = new LevelCreator();
        }
        gameState = 3;
      }
    };
  }

  public void chooseFile() {
    selectInput("Select a file to process:", "fileSelected", dataFile("MainMenu"), this);
  }

  public void fileSelected(File selection) {
    if (selection == null) {
      println("Something went wrong with choosing a file");
    } else {
      if (sm != null) {
        game = new Game(selection, sm.settings);
      } else {
        game = new Game(selection, new Settings(0));
      }
      gameState = 2;
    }
    isSelectingFile = false;
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
