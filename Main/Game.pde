public class Game {
  private Level level;
  private Player player;
  private int wave, maxWaves = 10;
  
  public Game(File f) {
    level = new Level(f);
    player = new Player();
  }

  public void update() {
    level.update();
  }

  public void render() {
    level.render(false);  //flere render ting som liv osv
    renderNonLevelThings();
  }
  
  private void renderNonLevelThings(){
    // måske et baggrundsbillede
    
    // rendering player stats
    // måske et billede af et hjerte
    textSize(50);  // alle textSize(x), så burde x være i forhold til height eller width
    textAlign(CENTER);
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0);  // nok ikke 255, når der er et billede
    text(player.getLife(), squaresX + (width-squaresX)/2, height/16);
    // måske et billede af et nogle MONEYS
    textSize(50);  // alle textSize(x), så burde x være i forhold til height eller width
    textAlign(CENTER);
    stroke(0);
    strokeWeight(1);
    fill(231, 202, 0);
    text(player.getMoney(), squaresX + (width-squaresX)/2, height/16*2);
    
    renderBuyables();
    
    // rendering details of the level
    textSize(50);  // alle textSize(x), så burde x være i forhold til height eller width
    textAlign(CENTER);
    stroke(0);
    strokeWeight(1);
    fill(255);
    text(wave + " / " + maxWaves, squaresX + (width-squaresX)/2, height/16*2);
  }
  
  private void renderBuyables(){
    // noget med at gette billederne fra towersene og render dem
  }
  
  public void mouseEvent(int x, int y){
    if(x < squaresX && y < squaresY) {
      level.addTower(new Tower(x, y));
    } else {
      // logic med liv og sådan noget der og at købe ting osv
    }
  }
}
