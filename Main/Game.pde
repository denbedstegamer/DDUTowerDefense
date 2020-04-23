public class Game {
  private Level level;
  private Player player;
  private Wave wave;
  private ArrayList<Projectile> projectiles;
  public boolean gaming, queueShouldBeCleared, boost;
  private Button startRound;

  private Tower selectedTower;
  private ArrayList<Button> upgrades;
  private ArrayList<Upgrade> upgrades2;
  private int temp;

  public Game(File f) {
    level = new Level(f);
    player = new Player();
    wave = new Wave();
    upgrades = new ArrayList<Button>();
    projectiles = new ArrayList<Projectile>();
    upgrades2 = new ArrayList<Upgrade>();
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
      if (wave.timeSinceWaveStarted >= 2 && wave.enemyCount == wave.totalEnemiesCount) {
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
    if (selectedTower != null && upgrades.size() == 0) {
      for (int i = 0; i < (selectedTower.getUpgrades().size()+1)/2; i++) {
        for (int j = 0; j < 2; j++) {
          if (i*2+j < selectedTower.getUpgrades().size()) {
            temp = i*2+j;
            upgrades2.add(new Upgrade(selectedTower.getUpgrades().get(temp)));
            Button tempB = new Button(squaresX+j*(width-squaresX)/2, height/8+height/8*i, (width-squaresX)/2, height/12, "Price: " + selectedTower.getUpgrades().get(i*2+j).getCost() + "\n Upgrade to a: " + selectedTower.getUpgrades().get(temp).getName()) {
              @Override
                public void action() {
                for (int i = 0; i < upgrades.size(); i++) {
                  if (upgrades.get(i).equals(this)) {
                    if (player.getMoney() >= upgrades2.get(i).getCost()) {
                      selectedTower.upgrade(upgrades2.get(i).getId());
                      player.MONEY -= upgrades2.get(i).getCost();
                      selectedTower = null;
                      queueShouldBeCleared = true;
                    }
                  }
                }
              }
            };
            upgrades.add(tempB);
          }
        }
      }
    }
    if (queueShouldBeCleared) {
      clearQueue();
    } else {
      for (int i = 0; i < upgrades.size(); i++) {
        upgrades.get(i).pressed();
        upgrades.get(i).render();
      }
    }
  }

  private void clearQueue() {
    upgrades.clear();
    upgrades2.clear();
    queueShouldBeCleared = false;
  }

  public void mouseEvent(int x, int y) {
    if (x < squaresX && y < squaresY) {
      boolean mouseIsOverTower = false;
      for (int i = 0; i < level.towers.size() && !mouseIsOverTower; i++) {
        if (dist(mouseX, mouseY, level.towers.get(i).pos.x, level.towers.get(i).pos.y) < level.towers.get(i).radius) {
          clearQueue();
          selectedTower = level.towers.get(i);
          mouseIsOverTower = true;
        }
      }
      if (!mouseIsOverTower) {
        if (player.getMoney() >= 50) {
          int currentTowerNumber = level.towers.size();
          level.addTower(new Tower(x, y));
          if(level.towers.size() > currentTowerNumber){
            player.MONEY -= 50;
          }
        }
      }
    } else {
      // logic med liv og sådan noget der og at købe ting osv
    }
  }
}
