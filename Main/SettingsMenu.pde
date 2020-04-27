public class SettingsMenu{
  private Settings settings;
  private Button backToMM, easy, medium, hard;
  
  public SettingsMenu(){
    this.settings = new Settings(0);
    easy = new Button(squaresX, height/2, width-squaresX, height/8, "Change to easy","","") {
      @Override
        public void action() {
        settings.changeDifficulty(0);
      }
    };
    medium = new Button(squaresX, height/2+height/8, width-squaresX, height/8, "Change to medium","","") {
      @Override
        public void action() {
        settings.changeDifficulty(1);
      }
    };
    hard = new Button(squaresX, height/2+height/4, width-squaresX, height/8, "Change to hard","","") {
      @Override
        public void action() {
        settings.changeDifficulty(2);
      }
    };
    backToMM = new Button(squaresX, height/2+height/4+height/8, width-squaresX, height/8, "Main Menu","","") {
      @Override
        public void action() {
        gameState = 0;
      }
    };
  }
  
  public void update(){
    backToMM.pressed();
    easy.pressed();
    medium.pressed();
    hard.pressed();
    // man skal kunne ændre settings
  }
  
  public void render(){
    background(255);
    easy.render();
    medium.render();
    hard.render();
    backToMM.render();
  }
}
