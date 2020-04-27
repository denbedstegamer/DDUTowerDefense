public class SettingsMenu{
  private Settings settings;
  private Button backToMM;
  
  public SettingsMenu(){
    this.settings = new Settings(0);
    
    backToMM = new Button(squaresX, height/2+height/4+height/8, width-squaresX, height/8, "Main Menu","","") {
      @Override
        public void action() {
        gameState = 0;
      }
    };
  }
  
  public void update(){
    backToMM.pressed();
    // man skal kunne ændre settings
  }
  
  public void render(){
    background(255);
    backToMM.render();
  }
}
