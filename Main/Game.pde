public class Game {
  private Level level;
  private Player player;
  private Wave wave;
  private ArrayList<Projectile> projectiles;
  public boolean gaming;
  private Button startRound;

  public Game(File f) {
    level = new Level(f);
    player = new Player();
    wave = new Wave();
    projectiles = new ArrayList<Projectile>();
    startRound = new Button(width-width/4-width/16, height-height/9, width/4, height/12, "Start round") {
      @Override
        public void action() {
        if (!gaming) {
          gaming = true;
          wave.waveCount++;
          wave.timeSinceWaveStarted = 0;
          wave.spawnEnemies();
        }
      }
    };
  }

  public void update() {
    level.update();
    if (gaming) {
      wave.update();
      removeCollidedProjectiles();
      for (int i = 0; i < projectiles.size(); i++) {
        projectiles.get(i).update();
      }
    }
    startRound.pressed();
    cleanUp();
  }

  //fjerner projektiler, som har ramt deres mål
  public void removeCollidedProjectiles() {
    for (int i = 0; i < projectiles.size(); i++) {
      if (projectiles.get(i).collided) {
        projectiles.remove(i);
        i--;
      }
    }
  }

  private void cleanUp() {
    boolean temp = false;
    for (int i = 0; i < wave.enemies.size() && !temp; i++) {
      if (wave.enemies.get(i) != null) {
        temp = true;
      }
    }
    if (!temp) {
      projectiles.clear();
      wave.enemies.clear();
      if (wave.timeSinceWaveStarted >= 2) {
        gaming = false;
      }
    }
  }

  public void render() {
    level.render(false);
    if (gaming) {
      wave.render();
      for (int i = 0; i < projectiles.size(); i++) {
        projectiles.get(i).render();
      }
    }
    renderNonLevelThings();
  }

  private void renderNonLevelThings() {
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
    fill(0);
    text("wave " + wave.waveCount + " / " + wave.maxWaves, squaresX + (width-squaresX)/2, height-height/16*2);

    startRound.render();
  }

  private void renderBuyables() {
    // noget med at gette billederne fra towersene og render dem
  }

  public void mouseEvent(int x, int y) {
    if (x < squaresX && y < squaresY) {
      //wave.enemies.add(new Enemy(0, level.track.points.get(0)));
      level.addTower(new Tower(x, y));
    } else {
      // logic med liv og sådan noget der og at købe ting osv
    }
  }
}
