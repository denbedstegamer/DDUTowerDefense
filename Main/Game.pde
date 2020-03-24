public class Game {
  private Level currentLevel;
  
  public Game() {
    currentLevel = new Level();  // nope
  }

  public void update() {
    currentLevel.update();
  }

  public void render() {
    currentLevel.render();  //flere render ting som liv osv
  }
  
  public void mouseEvent(int x, int y){
    if(x < squaresX && y < squaresY) {
      currentLevel.addTower(new Tower(x, y));
    } else {
      // logic med liv og sådan noget der og at købe ting osv
    }
  }
}
