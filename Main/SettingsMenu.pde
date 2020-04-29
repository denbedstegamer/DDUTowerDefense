public class SettingsMenu {
  private Settings settings;
  private Button backToMM, easy, medium, hard, sandbox;

  public SettingsMenu() {
    this.settings = new Settings(0);
    easy = new Button(width/2-width/8, height/2-height/3-height/36, width/4, height/8, "Easy", "", "") {
      @Override
        public void action() {
        settings.changeDifficulty(0);
        medium.pressed = false;
        hard.pressed = false;
        sandbox.pressed = false;
      }
    };
    
    medium = new Button(width/2-width/8, height/2-height/6-height/36, width/4, height/8, "Medium", "", "") {
      @Override
        public void action() {
        settings.changeDifficulty(1);
        easy.pressed = false;
        hard.pressed = false;
        sandbox.pressed = false;
      }
    };
    
    medium.pressed = true;
    hard = new Button(width/2-width/8, height/2-height/36, width/4, height/8, "Hard", "", "") {
      @Override
        public void action() {
        settings.changeDifficulty(2);
        easy.pressed = false;
        medium.pressed = false;
        sandbox.pressed = false;
      }
    };
    
    backToMM = new Button(width/2-width/6, height/2+height/6-height/36, width/3, height/8, "Main Menu", "", "") {
      @Override
        public void action() {
        gameState = 0;
      }
    };

    sandbox = new Button(width/2+width/8+width/36, height/2-height/36, width/10, height/8, "SB", "", "") {
      @Override
        public void action() {
        settings.changeDifficulty(3);
        easy.pressed = false;
        medium.pressed = false;
        hard.pressed = false;
      }
    };
  }

  public void update() {
    backToMM.pressed();
    easy.pressed();
    medium.pressed();
    hard.pressed();
    sandbox.pressed();
    // man skal kunne ændre settings
  }

  public void render() {
    background(255);

    easy.render();
    if (easy.pressed) {
      fill(0, 255, 0, 30);
      stroke(0, 255, 0);
      strokeWeight(5);
      rect(width/2-width/8, height/2-height/3-height/36, width/4, height/8);
      stroke(1);
    }
    medium.render();
    if (medium.pressed) {
      fill(255, 255, 0, 30);
      stroke(255, 255, 0);
      strokeWeight(5);
      rect(width/2-width/8, height/2-height/6-height/36, width/4, height/8);
      stroke(1);
    }
    hard.render();
    if (hard.pressed) {
      fill(255, 0, 0, 30);
      stroke(255, 0, 0);
      strokeWeight(5);
      rect(width/2-width/8, height/2-height/36, width/4, height/8);
      stroke(1);
    }
    
    sandbox.render();
    if (sandbox.pressed) {
      fill(178, 5, 255, 30);
      stroke(178, 5, 255);
      strokeWeight(5);
      rect(width/2+width/8+width/36, height/2-height/36, width/10, height/8);
      stroke(1);
    }
    backToMM.render();
  }
}
