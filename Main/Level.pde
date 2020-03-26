public class Level {
  private Track track;
  private FieldPiece[][] field;
  private ArrayList<Tower> towers;
  private String filePathToBackGround;

  public Level() {
    track = new Track();
    field = new FieldPiece[squaresX][squaresY];
    for (int x = 0; x < squaresX; x++) {
      for (int y = 0; y < squaresY; y++) {
        field[x][y] = new FieldPiece(x, y, true);
      }
    }
    towers = new ArrayList<Tower>();
  }

  public Track getTrack() {
    return track;
  }

  //maybe not int for TT
  public boolean canAddTower(int x, int y, int towerRadius) {
    // Logic concerning placing the tower so that it can't touch the other towers or the field
    int xTemp2 = x-towerRadius;
    if (xTemp2 < 0) {
      xTemp2 = 0;
    }
    int yTemp2 = y-towerRadius;
    if (yTemp2 < 0) {
      yTemp2 = 0;
    }
    for (int xTemp = xTemp2; xTemp < x+towerRadius; xTemp++) {
      for (int yTemp = yTemp2; yTemp < y+towerRadius; yTemp++) {
        if(xTemp >= squaresX){
          return false;
        }
        if(yTemp >= squaresY){
          return false;
        }
        for (int i = 0; i < 4; i++) {
          float[] tempCoords = field[xTemp][yTemp].getCorner(i);
          if (dist(x, y, tempCoords[0], tempCoords[1]) < towerRadius) {
            if (!field[xTemp][yTemp].isEmpty) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  public void addTower(Tower t) {
    if (canAddTower(t.getX(), t.getY(), t.getRadius())) {
      towers.add(new Tower(t.getX(), t.getY()));
      int xTemp2 = t.getX()-t.getRadius();
      if (xTemp2 < 0) {
        xTemp2 = 0;
      }
      if (xTemp2 > squaresX) {
        xTemp2 = squaresX;
      }
      int yTemp2 = t.getY()-t.getRadius();
      if (yTemp2 < 0) {
        yTemp2 = 0;
      }
      if (yTemp2 > squaresY) {
        yTemp2 = squaresY;
      }
      for (int xTemp = xTemp2; xTemp < t.getX()+t.getRadius(); xTemp++) {
        for (int yTemp = yTemp2; yTemp < t.getY()+t.getRadius(); yTemp++) {
          for (int i = 0; i < 4; i++) {
            float[] tempCoords = field[xTemp][yTemp].getCorner(i);
            if (dist(t.getX(), t.getY(), tempCoords[0], tempCoords[1]) < t.getRadius()) {
              field[xTemp][yTemp].isEmpty = false;
            }
          }
        }
      }
    }
  }

  public void RenderTowers() {
    for (int i = 0; i < towers.size(); i++) {
      if (towers.get(i) != null) {
        towers.get(i).render();
      }
    }
  }
  
  public void update() {
    
  }

  public void render() {
    background(255);
    rectMode(CORNER);
    noStroke();
    for (int x = 0; x < squaresX; x++) {
      for (int y = 0; y < squaresY; y++) {
        field[x][y].render();
      }
    }
    RenderTowers();
    renderBackground();
  }
  
  public void renderBackground(){
    if(filePathToBackGround != null){
      tint(255, 100);
      image(loadImage(filePathToBackGround), 0, 0, squaresX, squaresY);
    }
  }
}
