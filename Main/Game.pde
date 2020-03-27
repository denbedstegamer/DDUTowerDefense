public class Game {
  private Level level;
  
  public Game(File f) {
    level = new Level(f);
  }

  public void update() {
    level.update();
  }

  public void render() {
    level.render(false);  //flere render ting som liv osv
  }
  
  public void mouseEvent(int x, int y){
    if(x < squaresX && y < squaresY) {
      level.addTower(new Tower(x, y));
    } else {
      // logic med liv og sådan noget der og at købe ting osv
    }
  }
}
