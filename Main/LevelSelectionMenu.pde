public class LevelSelectionMenu {
  ArrayList<File> levels;
  ArrayList<Button> buttons;
  private Button toGame;

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
      buttons.add(new Button((i%3)*width/6+width/4, (i/3)*width/9+height/8, width/7, height/7, temp, i) {
        @Override
          public void action() {
          if (game == null) {
            if (sm != null) {
              game = new Game(levels.get(buttonNumber), sm.settings);
            } else {
              game = new Game(levels.get(buttonNumber), new Settings(1));
            }
          }
          for (int b = 0; b < buttons.size(); b++) {
            if (b != buttonNumber) {
              buttons.get(b).pressed = false;
            }
          }
        }
      }
      );
    }

    toGame = new Button(width/2-width/12, height/4+height/2, width/6, height/10, "Play", "", "") {
      @Override
        public void action() {
        if (game != null) {
          gameState = 2;
        }
        delay(25);
      }
    };
  }

  public void update() {
    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).pressed();
      toGame.pressed();
    }
  }

  public void render() {
    background(255);
    for (int i = 0; i < buttons.size(); i++) {

      if (buttons.get(i).pressed) {
        fill(0, 240, 0, 30);
        stroke(0, 240, 0);
        strokeWeight(8);
        rect(buttons.get(i).pos.x, buttons.get(i).pos.y, buttons.get(i).size.x, buttons.get(i).size.y);
        stroke(2);
      }

      buttons.get(i).render();
      toGame.render();
    }
  }
}
