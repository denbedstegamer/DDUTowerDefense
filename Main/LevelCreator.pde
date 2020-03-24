public class LevelCreator {
  //private TextField levelName;
  private Level level;
  private Button createLevel, chooseBackground;
  private boolean isSelectingFile;

  public LevelCreator() {
    level = new Level();
    
    chooseBackground = new Button(1000, 0, width-1000, height/8, "Background") {
      @Override
        public void action() {
        if(!isSelectingFile){
          chooseBackground();
        }
        isSelectingFile = true;
      }
    };
    createLevel = new Button(1000, height/8, width-1000, height/8, "Create Level") {
      @Override
        public void action() {
        createLevel();
      }
    };
    //levelName = new TextField("input level name");
    //add(levelName);
  }

  public void createEnemyWalkSpace() {
  }

  public void createEnemyWalkPath() {
  }
  
  public void chooseBackground(){
    selectInput("Select a background:", "fileSelected");
  }
  
  public void fileSelected(File selection){
    if(selection == null){
      println("No file was selected");
    } else {
      level.filePathToBackGround = selection.getAbsolutePath();
    }
    isSelectingFile = false;
    println(level.filePathToBackGround);
  }

  public void createLevel() {
    PrintWriter output = createWriter("data/field.lvl");  // "data/field" + number + ".lvl"
    output.println(level.filePathToBackGround);
    String[][] data = new String[level.field[0].length][level.field[1].length];
    for (int x = 0; x < level.field[0].length; x++) {
      for (int y = 0; y < level.field[1].length; y++) {
        if(level.field[x][y].isEmpty){
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
  
  public void update(){
    chooseBackground.pressed();
    createLevel.pressed();
  }
  
  public void render(){
    background(255);
    level.render();
    chooseBackground.render();
    createLevel.render();
  }
}
