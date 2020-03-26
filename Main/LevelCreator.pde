public class LevelCreator {
  //private TextField levelName;
  private Level level;
  private Button createLevel, chooseBackground, createObstacle, createPath, clearPath, stopPath;
  private boolean isSelectingFile, isSettingMarks, isSettingPath;
  private String toolTip;
  private PVector[] marks;
  private ArrayList<PVector> path;

  public LevelCreator() {
    level = new Level();
    marks = new PVector[4];
    path = new ArrayList<PVector>();

    chooseBackground = new Button(1000, 0, width-1000, height/8, "Background") {
      @Override
        public void action() {
        if (!isSelectingFile) {
          chooseBackground();
        }
        isSelectingFile = true;
      }
    };
    createLevel = new Button(1000, height/8, width-1000, height/8, "Create Level") {
      @Override
        public void action() {
        createLevel();
        toolTip = "Level saved";
      }
    };
    createObstacle = new Button(1000, height/4-1, width-1000, height/8, "Obstacle") {
      @Override
        public void action() {
        isSettingMarks = true;
        isSettingPath = false;
        clearMarks();
        toolTip = "Click on the field in order to mark the 4 corners of the obstacle";
      }
    };
    createPath = new Button(1000, height/4+height/8-1, width-1000, height/8, "Create Path") {
      @Override
        public void action() {
        isSettingPath = true;
        isSettingMarks = false;
        toolTip = "Click on the field in order to trace the path for the enemies";
      }
    };
    stopPath = new Button(1000, height/2-2, width-1000, height/8, "Stop Path") {
      @Override
        public void action() {
        isSettingPath = false;
        toolTip = "You no longer place path";
      }
    };
    clearPath = new Button(1000, height/2+height/8-2, width-1000, height/8, "Clear Path") {
      @Override
        public void action() {
        clearPath();
        toolTip = "Path cleared";
      }
    };
    //levelName = new TextField("input level name");
    //add(levelName);
  }

  public void chooseBackground() {
    selectInput("Select a file to process:", "fileSelected", dataFile("LevelCreator"), this);
  }

  public void clickEvent() {
    if (isSettingMarks) {
      setMark();
    }
    if (isSettingPath) {
      makePath();
    }
  }

  public void setMark() {
    if (mouseX < squaresX && mouseY < squaresY) {
      boolean temp = true;
      for (int i = 0; i < marks.length && temp; ) {
        if (marks[i] == null) {
          marks[i] = new PVector(round(mouseX), round(mouseY));
          temp = false;
        } else {
          i++;
        }
      }
      if (!(marks[3] == null)) {
        createObstacle();
        isSettingMarks = false;
        clearMarks();
      }
    }
  }

  public void clearMarks() {
    for (int i = 0; i < marks.length; i++) {
      marks[i] = null;
    }
  }

  public void makePath() {
    if (mouseX < squaresX && mouseY < squaresY) {
      path.add(new PVector(round(mouseX), round(mouseY)));
    }
  }

  public void setPath() {
    for (int i = 0; i < path.size(); i++) {
      level.track.getTrack()[round(path.get(i).x)][round(path.get(i).y)] = i;
    }
  }

  public void clearPath() {
    for (int i = path.size()-1; i >= 0; i--) {
      path.remove(i);
    }
  }

  public void createObstacle() {
    int xMin = round(marks[0].x);
    for (int i = 1; i < marks.length; i++) {
      if (marks[i].x < xMin) {
        xMin = round(marks[i].x);
      }
    }
    int yMin = round(marks[0].y);
    for (int i = 1; i < marks.length; i++) {
      if (marks[i].y < yMin) {
        yMin = round(marks[i].y);
      }
    }
    int xMax = round(marks[0].x);
    for (int i = 1; i < marks.length; i++) {
      if (marks[i].x > xMax) {
        xMax = round(marks[i].x);
      }
    }
    int yMax = round(marks[0].y);
    for (int i = 1; i < marks.length; i++) {
      if (marks[i].y > yMax) {
        yMax = round(marks[i].y);
      }
    }
    for (int x = xMin; x < xMax; x++) {
      for (int y = yMin; y < yMax; y++) {
        level.field[x][y].setEmpty(false);
      }
    }
  }

  public void fileSelected(File selection) {
    if (selection == null) {
      println("No file was selected");
    } else {
      level.filePathToBackGround = selection.getAbsolutePath();
    }
    isSelectingFile = false;
  }

  public void createLevel() {
    PrintWriter output = createWriter("data/field.lvl");  // "data/field" + number + ".lvl"
    output.println(level.filePathToBackGround);
    String[][] data = new String[level.field[0].length][level.field[1].length];
    for (int x = 0; x < level.field[0].length; x++) {
      for (int y = 0; y < level.field[1].length; y++) {
        if (level.field[x][y].isEmpty) {
          data[x][y] = "0";
        } else {
          data[x][y] = "1";
        }
      }
    }
    for (int x = 0; x < level.field[0].length; x++) {
      for (int y = 0; y < level.field[1].length; y++) {
        output.print(data[x][y]);
      }
      output.println();
    }
    output.flush();
    output.close();
  }

  public void update() {
    chooseBackground.pressed();
    createLevel.pressed();
    createObstacle.pressed();
    createPath.pressed();
    stopPath.pressed();
    clearPath.pressed();
  }

  public void render() {
    background(255);
    level.render();
    chooseBackground.render();
    createLevel.render();
    createObstacle.render();
    createPath.render();
    stopPath.render();
    clearPath.render();

    if (toolTip != null) {
      textSize(32);
      textAlign(CENTER);
      fill(0);
      text(toolTip, width/2, height-height/10);
    }

    if (isSettingMarks) {
      noStroke();
      fill(0, 255, 0);
      for (int i = 0; i < marks.length; i++) {
        if (marks[i] != null) {
          ellipse(marks[i].x, marks[i].y, 4, 4);
        }
      }
    }
    noStroke();
    for (int i = 0; i < path.size(); i++) {
      fill(255*i/path.size(), 0, 0);
      ellipse(round(path.get(i).x), round(path.get(i).y), 3, 3);
    }
  }
}
