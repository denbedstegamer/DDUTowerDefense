public class LevelCreator {
  //private TextField levelName;
  private Level level;
  private Button createLevel, chooseBackground, createObstacle, createPath, clearPath, stopPath, chooseLevel, backToMM;
  private boolean isSelectingFile, isSelectingBackgroundFile, isSelectingLevelFile, isSettingMarks, isSettingPath, changesToFeatures = true;
  private String toolTip;
  private PVector[] marks;
  private PImage features;

  public LevelCreator() {
    level = new Level();
    marks = new PVector[4];
    features = new PImage();

    chooseBackground = new Button(1000, 0, width-1000, height/8, "Background") {
      @Override
        public void action() {
        if (!isSelectingFile) {
          isSelectingBackgroundFile = true;
          isSelectingFile = true;
          chooseFile();
        }
        toolTip = null;
      }
    };
    createLevel = new Button(1000, height/8, width-1000, height/8, "Create Level") {
      @Override
        public void action() {
        createLevel();
        toolTip = "Level saved";
      }
    };
    createObstacle = new Button(1000, height/4, width-1000, height/8, "Obstacle") {
      @Override
        public void action() {
        isSettingMarks = true;
        isSettingPath = false;
        clearMarks();
        toolTip = "Click on the field in order to mark the 4 corners of the obstacle";
      }
    };
    createPath = new Button(1000, height/4+height/8, width-1000, height/8, "Create Path") {
      @Override
        public void action() {
        isSettingPath = true;
        isSettingMarks = false;
        toolTip = "Click on the field in order to trace the path for the enemies";
      }
    };
    stopPath = new Button(1000, height/2, width-1000, height/8, "Stop Path") {
      @Override
        public void action() {
        isSettingPath = false;
        toolTip = "You no longer place path";
      }
    };
    clearPath = new Button(1000, height/2+height/8, width-1000, height/8, "Clear Path") {
      @Override
        public void action() {
        clearPath();
        toolTip = "Path cleared";
      }
    };
    chooseLevel = new Button(1000, height/2+height/4, width-1000, height/8, "Edit Level") {
      @Override
        public void action() {
        if (!isSelectingFile) {
          isSelectingLevelFile = true;
          chooseFile();
          isSelectingFile = true;
        }
        toolTip = null;
      }
    };
    backToMM = new Button(1000, height/2+height/4+height/8, width-1000, height/8, "Main Menu") {
      @Override
        public void action() {
        gameState = 0;
      }
    };
  }

  public void chooseFile() {
    selectInput("Select a file to process:", "fileSelected", dataFile("LevelCreator"), this);
  }

  public void fileSelected(File selection) {
    if (selection == null) {
      toolTip = "Something went wrong with choosing a file";
    } else {
      changesToFeatures = true;
      if (isSelectingBackgroundFile) {
        level.filePathToBackground = selection.getAbsolutePath();
        isSelectingBackgroundFile = false;
        isSelectingFile = false;
      }
      if (isSelectingLevelFile) {
        level = new Level(selection);
        isSelectingLevelFile = false;
        isSelectingFile = false;
      }
    }
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
      level.track.getPoints().add(new PVector(round(mouseX), round(mouseY)));
    }
  }

  public void clearPath() {
    for (int i = level.track.getPoints().size()-1; i >= 0; i--) {
      level.track.getPoints().remove(i);
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
    changesToFeatures = true;
  }

  public void createLevel() {
    PrintWriter output = createWriter("data/field.lvl");  // "data/field" + number + ".lvl"

    output.println(level.filePathToBackground);

    output.println("Field");
    String[][] dataField = new String[squaresX][squaresY];
    for (int y = 0; y < squaresY; y++) {
      for (int x = 0; x < squaresX; x++) {
        if (level.field[x][y].isEmpty) {
          dataField[x][y] = "0";
        } else {
          dataField[x][y] = "1";
        }
      }
    }
    for (int y = 0; y < squaresY; y++) {
      for (int x = 0; x < squaresX; x++) {
        output.print(dataField[x][y]);
      }
      output.println();
    }

    output.println("Track");
    String[] dataTrack = new String[level.track.getPoints().size()];
    for (int i = 1; i < dataTrack.length; i++) {
      dataTrack[i] = level.track.getPoints().get(i).toString().substring(2, level.track.getPoints().get(i).toString().length()-2);
    }
    for (int i = 1; i < dataTrack.length; i++) {
      output.println(dataTrack[i]);
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
    chooseLevel.pressed();
    backToMM.pressed();
  }

  public void render() {
    background(255);
    if (changesToFeatures) {
      level.render(true);
      features = get();
      changesToFeatures = false;
    }
    image(features, 0, 0);
    
    chooseBackground.render();
    createLevel.render();
    createObstacle.render();
    createPath.render();
    stopPath.render();
    clearPath.render();
    chooseLevel.render();
    backToMM.render();

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
    for (int i = 0; i < level.track.getPoints().size(); i++) {
      fill(127 + 128*i/level.track.getPoints().size(), 0, 0);
      ellipse(round(level.track.getPoints().get(i).x), round(level.track.getPoints().get(i).y), 3, 3);
    }
  }
}
