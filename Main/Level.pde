public class Level {
  private Track track;
  private FieldPiece[][] field;
  private ArrayList<Tower> towers;
  private String filePathToBackground, absolutePath;
  private PImage background, background2;  // background2 is to make the game not lag, because processing is terrible with images

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

  public Level(File f) {
    absolutePath = f.getAbsolutePath();
    String[] contents = loadStrings(f);

    if (contents[0].compareTo("null") != 0) {
      filePathToBackground = contents[0];
    } else {
      filePathToBackground = null;
    }

    field = new FieldPiece[squaresX][squaresY];
    for (int x = 0; x < squaresX; x++) {
      for (int y = 0; y < squaresY; y++) {
        field[x][y] = new FieldPiece(x, y, true);
      }
    }
    for (int y = 0; y < squaresY; y++) {
      for (int x = 0; x < contents[y].length(); x++) {
        if (contents[y + 2].charAt(x) == '0') {
          field[x][y].setEmpty(true);
        } else {
          field[x][y].setEmpty(false);
        }
      }
    }

    track = new Track();
    for (int y = squaresY + 3; y < contents.length; y++) {
      String[] coords = split(contents[y], ",");
      float Px = parseFloat(coords[0]);
      float Py = parseFloat(coords[1]);
      PVector point = new PVector(Px, Py);
      getTrack().getPoints().add(point);
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
        if (xTemp >= squaresX) {
          return false;
        }
        if (yTemp >= squaresY) {
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
  
  public void removeObstaclesFromTower(Tower t){
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
              field[xTemp][yTemp].isEmpty = true;
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
    for (int i = 0; i < towers.size(); i++) {
      if (towers.get(i) != null) {
        towers.get(i).update();
      }
    }
  }

  public void render(boolean toLevelCreator) {
    background(255);
    if (!toLevelCreator) {
      renderBackground(false);
    }
    RenderTowers();
    if (toLevelCreator) {
      renderBackground(toLevelCreator);
      rectMode(CORNER);
      noStroke();
      for (int x = 0; x < squaresX; x++) {
        for (int y = 0; y < squaresY; y++) {
          field[x][y].render();
        }
      }
      renderBackground(toLevelCreator);
    }
  }

  public void renderBackground(boolean toLevelCreator) {
    if (background == null) {
      if (filePathToBackground != null) {
        noTint();
        background = loadImage(dataPath("") + filePathToBackground);
        imageMode(CORNER);
        image(background, 0, 0, squaresX, squaresY);
        background2 = get();
      }
    }
    if (background != null) {
      if (toLevelCreator) {
        tint(255, 100);
      } else {
        noTint();
      }
      imageMode(CORNER);
      image(background2, 0, 0);
    }
  }
}
