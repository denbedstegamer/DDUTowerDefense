import processing.sound.*;

public class Game {
  private Level level;
  private Player player;
  private Wave wave;
  private ArrayList<Projectile> projectiles;
  public boolean gaming, queueShouldBeCleared, boost;
  private Button startRound, buyPeasant, backToMM;
  private boolean gameOver, isBuyingPeasant;

  private Tower selectedTower;
  private ArrayList<Button> upgrades;
  private ArrayList<Upgrade> upgrades2;
  private int temp;
  private float healthMultiplier, priceMultiplier;
  public int sizeX = 200;

  private PImage hearts;
  private PImage coins;

  public Game(File f, Settings s) {
    hearts = loadImage(dataPath("") + "/Particles/Heart.png");
    coins = loadImage(dataPath("") + "/Particles/Coin.png");
    level = new Level(f);
    level.background = null;
    level.background2 = null;
    player = new Player(s.life, s.startMoney);
    wave = new Wave();
    upgrades = new ArrayList<Button>();
    projectiles = new ArrayList<Projectile>();
    upgrades2 = new ArrayList<Upgrade>();
    
    backToMM = new Button(squaresX+(width-squaresX)-(width-squaresX)/4, height/64, width/12, height/18, "Main Menu", "", "") {
      @Override
        public void action() {
        gameState = 0;
      }
    };
    
    startRound = new Button(width/36+(width-squaresX)/2, squaresY+(height-squaresY)/4, (width-squaresX)/2, height/8, "Start Round", "", "") {
      @Override
        public void action() {
        if (!gaming) {
          gaming = true;
          wave.spawnEnemies();
        }
      }
    };
    buyPeasant = new Button(width/72, squaresY+(height-squaresY)/4, (width-squaresX)/2, height/8, "", "Buy Peasant", "\n Price: 50") {
      @Override
        public void action() {
        isBuyingPeasant = true;
      }
    };
    priceMultiplier = s.priceMultiplier;
    healthMultiplier = s.healthMultiplier;
  }

  public void update() {
    if (!gameOver) {
      if (gaming) {
        wave.update();
        if (wave.timeSinceWaveStarted >= 2) {
          level.update();
          for (int i = 0; i < projectiles.size(); i++) {
            projectiles.get(i).update();
          }
          removeCollidedProjectiles();
        }
      }
    }
    startRound.pressed();
    buyPeasant.pressed();
    backToMM.pressed();
    if (player.life <= 0) {
      gaming = false;
      gameOver = true;
      text("You died", width/8, height-height/16);
    }
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
    textAlign(RIGHT);
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0);  // nok ikke 255, når der er et billede
    text(player.getLife(), squaresX+(width-squaresX)-(width-squaresX)/4-(width-squaresX)/12, height/16);
    // måske et billede af et nogle MONEYS
    imageMode(CORNER);
    image(hearts, squaresX+(width-squaresX)-(width-squaresX)/4-(width-squaresX)/12, height/36, (width-squaresX)/22, (width-squaresX)/22);
    image(coins, squaresX+(width-squaresX)-(width-squaresX)/4-(width-squaresX)/12, height/11, (width-squaresX)/24, (width-squaresX)/24);
    textSize(50);  // alle textSize(x), så burde x være i forhold til height eller width
    textAlign(RIGHT);
    stroke(0);
    strokeWeight(1);
    fill(231, 202, 0);
    text(round(player.getMoney()), squaresX+(width-squaresX)-(width-squaresX)/4-(width-squaresX)/12, height/16*2);

    renderBuyables();

    // rendering details of the level
    textSize(50);  // alle textSize(x), så burde x være i forhold til height eller width
    textAlign(LEFT);
    stroke(0);
    strokeWeight(1);
    fill(0);
    text("wave " + wave.waveCount + " / " + wave.maxWaves, (width-squaresX)/2+(width-squaresX)/7, squaresY+(height-squaresY)-(height-squaresY)/4);

    if (isBuyingPeasant && player.money >= 50) {
      if (!level.canAddTower(mouseX, mouseY, 20)) {
        tint(255, 0, 0, 100);
      }
      imageMode(CENTER);
      PImage sprite = loadImage(dataPath("") + "/Towers/1.png");
      image(sprite, mouseX, mouseY);
      noTint();
    }

    startRound.render();
    buyPeasant.render();
    backToMM.render();
  }

  private void renderBuyables() {
    if (selectedTower != null && upgrades.size() == 0) {
      //for (int i = 0; i < (selectedTower.getUpgrades().size()+1)/2; i++) {
      for (int j = 0; j < 3; j++) {
        if (j < selectedTower.getUpgrades().size()) {
          temp = j;
          upgrades2.add(new Upgrade(selectedTower.getUpgrades().get(temp)));
          Button tempB = new Button(squaresX+(width-squaresX)/4, height/6+height/8*j+j*25, (width-squaresX)/2, height/7, "", "Price: " + round(selectedTower.getUpgrades().get(j).getCost()), "\n Upgrade to: " + selectedTower.getUpgrades().get(temp).getName()) {
            @Override
              public void action() {
              for (int i = 0; i < upgrades.size(); i++) {
                if (upgrades.get(i).equals(this)) {
                  if (player.getMoney() >= upgrades2.get(i).getCost()) {
                    selectedTower.upgrade(upgrades2.get(i).getId());
                    player.addMoney(-upgrades2.get(i).getCost());
                    selectedTower.moneySpent += upgrades2.get(i).getCost();
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
      Button tempB = new Button(squaresX+(width-squaresX)/4, height/6+height/8*upgrades.size()+upgrades.size()*25, (width-squaresX)/2, height/7, "Sell", "80% of cost refunded", "") {
        @Override
          public void action() {
          for (int i = 0; i < upgrades.size(); i++) {
            if (upgrades.get(i).equals(this)) {
              player.addMoney(selectedTower.moneySpent*0.8);
              for (int j = 0; j < level.towers.size(); j++) {
                if(level.towers.get(j).equals(selectedTower)){
                  level.removeObstaclesFromTower(level.towers.get(j));
                  level.towers.remove(j);
                }
              }
              selectedTower = null;
              queueShouldBeCleared = true;
            }
          }
        }
      };
      upgrades.add(tempB);
    }

    if (queueShouldBeCleared) {
      clearQueue();
    } else {
      for (int i = 0; i < upgrades.size(); i++) {
        if (!gameOver) {
          upgrades.get(i).pressed();
          upgrades.get(i).render();
        }
      }
    }
  }

  private void clearQueue() {
    upgrades.clear();
    upgrades2.clear();
    queueShouldBeCleared = false;
  }

  public void mouseEvent(int x, int y) {
    if (!gameOver) {
      if (x < squaresX && y < squaresY) {
        boolean mouseIsOverTower = false;
        for (int i = 0; i < level.towers.size() && !mouseIsOverTower; i++) {
          if (dist(mouseX, mouseY, level.towers.get(i).pos.x, level.towers.get(i).pos.y) < level.towers.get(i).radius && !isBuyingPeasant) {
            clearQueue();
            selectedTower = level.towers.get(i);
            mouseIsOverTower = true;
          }
        }
        if (!mouseIsOverTower) {
          selectedTower = null;
          queueShouldBeCleared = true;
          if (isBuyingPeasant) {
            if (player.getMoney() >= 50) {
              int currentTowerNumber = level.towers.size();
              level.addTower(new Tower(x, y));
              if (level.towers.size() > currentTowerNumber) {
                player.addMoney(-50);
                isBuyingPeasant = false;
              }
            }
          }
        }
      } else {
        isBuyingPeasant = false;
        for (int i = 0; i < upgrades.size(); i++) {
          if (!gameOver) {
            upgrades.get(i).pressed();
          }
        }
        selectedTower = null;
        queueShouldBeCleared = true;
      }
    }
  }
}
