public class LevelSelectionMenu {
  ArrayList<File> levels;
  ArrayList<Button> buttons;

  public LevelSelectionMenu() {
    levels = new ArrayList<File>();
    buttons = new ArrayList<Button>();
    File[] levelPaths = listFiles(dataPath("") + "/levels/");
    for (int i = 0; i < levelPaths.length; i++) {
      levels.add(new File(levelPaths[i].getAbsolutePath()));
      String[] contents = loadStrings(levelPaths[i]);
      PImage temp;
      if (contents[0].compareTo("null") != 0) {
        temp = loadImage(dataPath("") + contents[0]);
      } else {
        temp = null;
      }
      buttons.add(new Button((i%3)*width/6+width/4, (i/3)*height/5+height/8, squaresX/4, squaresY/4, temp, i) {
        @Override
          public void action() {
          if (game == null) {
            if (sm != null) {
              game = new Game(levels.get(buttonNumber), sm.settings);
            } else {
              game = new Game(levels.get(buttonNumber), new Settings(1));
            }
            gameState = 2;
          }
        }
      }
      );
    }
  }

  public void update() {
    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).pressed();
    }
  }

  public void render() {
    background(255);
    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).render();
    }
  }
}
