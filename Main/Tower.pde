public class Tower {
  private int x, y, radius = 20, extend, timeSinceLastAttacked;
  private int range, damage, as, id, targetEnemy, cycle, minionLifeSpan, minionSpawn, moneySpent = 50;  // as = Attack Speed
  private PVector pos, dir;
  private PImage sprite;
  private Tower[] minions;
  private boolean readyToAttack;

  public Tower(int x, int y) {
    this.x = x;
    this.y = y;
    pos = new PVector(x, y);
    dir = new PVector(-1, 0);
    id = 1;
    updateTowerValues();

    sprite = loadImage(dataPath("") + "/Towers/" + id + ".png");
  }

  public void update() {
    if (game.boost) {
      extend = 3;
    } else {
      extend = 5;
    }
    if (timeSinceLastAttacked % (as*extend) == 0) {
      readyToAttack = true;
    }
    if (readyToAttack) {
      if(attack()){
        timeSinceLastAttacked = 0;
        readyToAttack = false;
      }
    }

    if (id == 9) {
      updateMinionLife();
      updateMinions();
    }
    timeSinceLastAttacked++;
  }

  public void render() {
    /*
    non-sprite rendering
     ellipseMode(CENTER);
     stroke(0);
     strokeWeight(1);
     fill(0, 255, 0);
     ellipse(x, y, radius*2, radius*2);
     */

    pushMatrix();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    if (dir.y > 0) {
      rotate(-PVector.angleBetween(dir, new PVector(-1, 0)));
    } else {
      rotate(PVector.angleBetween(dir, new PVector(-1, 0)));
    }
    image(sprite, 0, 0);
    popMatrix();
    if (id == 9) {
      renderMinions();
    }
  }

  public int getRadius() {
    return radius;
  }

  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }

  private void updateTowerValues() {
    switch(id) {
      //peasant
    case 1:
      as = 9;
      range = 150;
      break;

      //archer
    case 2:
      as = 6;
      range = 250;
      break;

      //knight
    case 3:
      as = 5;
      range = 60;
      damage = 20;
      break;

      //mage
    case 4:
      as = 11;
      range = 250;
      break;

      //arrowflinger
    case 5:
      as = 5;
      range = 260;
      break;

      //sniper
    case 6:
      as = 12;
      range = 10000;
      break;

      //barbarian
    case 7:
      as = 2;
      range = 60;
      damage = 24;
      break;

      //king
    case 8:
      as = 5;
      range = 80;
      damage = 26;
      break;

      //summoner
    case 9:
      as = 11;
      range = 250;
      minions = new Tower[3];
      minionSpawn = 200;
      break;

      //archmage
    case 10:
      as = 3;
      range = 300;
      cycle = 1;
      break;

      //void summon
    case 11:
      as = 8;
      range = 200;
      minionLifeSpan = 550;
      break;
    }
  }

  public void upgrade(int id) {
    this.id = id;
    if (id == 8) {
      game.boost = true;
    }
    sprite = loadImage(dataPath("") + "/Towers/" + id + ".png");
    updateTowerValues();
  }

  public ArrayList<Upgrade> getUpgrades() {
    ArrayList<Upgrade> upgrades = new ArrayList<Upgrade>();
    switch(id) {
    case 1:
      upgrades.add(new Upgrade("Archer", 2, 30));
      upgrades.add(new Upgrade("Knight", 3, 60));
      upgrades.add(new Upgrade("Mage", 4, 90));
      break;

    case 2:
      upgrades.add(new Upgrade("ArrowFlinger", 5, 120));
      upgrades.add(new Upgrade("Sniper", 6, 100));
      break;

    case 3:
      upgrades.add(new Upgrade("Barbarian", 7, 140));
      upgrades.add(new Upgrade("King", 8, 180));
      break;

    case 4:
      upgrades.add(new Upgrade("Summoner", 9, 140));
      upgrades.add(new Upgrade("Archmage", 10, 200));
      break;
    }
    return upgrades;
  }

  private void spotEnemy() {
    for (int i = 0; i < game.wave.enemies.size(); i++) {
      if (game.wave.enemies.get(i) != null) {
        if (PVector.dist(pos, game.wave.enemies.get(i).pos) < range) {
          targetEnemy = i;
          dir = game.wave.enemies.get(i).pos.copy().sub(pos);
          break;
        } else {
          targetEnemy = -1;
        }
      }
    }
    boolean temp = true;
    for (int i = 0; i < game.wave.enemies.size(); i++) {
      if (game.wave.enemies.get(i) != null) {
        temp = false;
      }
    }
    if (temp) {
      targetEnemy = -1;
    }
  }

  private boolean attack() {
    spotEnemy();
    if (targetEnemy > -1) {
      switch(id) {

        //peasant
      case 1:
        game.projectiles.add(new Projectile(pos, targetEnemy, id));
        break;

        //archer
      case 2:
        game.projectiles.add(new Projectile(pos, dir.copy(), id));
        break;

        //knight
      case 3:
        for (int i = 0; i < game.wave.enemies.size(); i++) {
          if (game.wave.enemies.get(i) != null) {
            if (game.wave.enemies.get(i).pos.copy().sub(pos).mag() < range) {
              game.wave.enemies.get(i).reduceLife(damage);
            }
          }
        }
        break;

        //mage
      case 4:
        game.projectiles.add(new Projectile(pos, targetEnemy, id));
        break;

        //arrowflinger
      case 5:
        game.projectiles.add(new Projectile(pos, dir.copy(), id));
        game.projectiles.add(new Projectile(pos, dir.copy().rotate(-PI/16), id));
        game.projectiles.add(new Projectile(pos, dir.copy().rotate(PI/16), id));
        break;

        //sniper
      case 6:
        game.projectiles.add(new Projectile(pos, dir.copy(), id));
        break;

        //barbarian
      case 7:
        for (int i = 0; i < game.wave.enemies.size(); i++) {
          if (game.wave.enemies.get(i) != null) {
            if (game.wave.enemies.get(i).pos.copy().sub(pos).mag() < range) {
              game.wave.enemies.get(i).reduceLife(damage);
            }
          }
        }
        break;

        //king
      case 8:
        for (int i = 0; i < game.wave.enemies.size(); i++) {
          if (game.wave.enemies.get(i) != null) {
            if (game.wave.enemies.get(i).pos.copy().sub(pos).mag() < range) {
              game.wave.enemies.get(i).reduceLife(damage);
            }
          }
        }
        break;

        //summoner
      case 9:
        game.projectiles.add(new Projectile(pos, targetEnemy, id));
        break;

        //archmage
      case 10:
        game.projectiles.add(new Projectile(pos, targetEnemy, id+cycle));
        spellCycle();
        break;

        //void summon
      case 11:
        game.projectiles.add(new Projectile(pos, targetEnemy, id+100));
        break;
      }
      attackSound(id);
    } else {
      return false;
    }
    return true;
  }

  private void spellCycle() {
    switch(cycle) {
    case 0:
      cycle = 1;
      break;
    case 1:
      cycle = 2;
      break;
    case 2:
      cycle = 0;
      break;
    }
  }

  private void spawnMinion() {
    minionSpawn--;
    if (minionSpawn <= 0) {
      for (int i = 0; i < 3; i++) {
        if (minions[i] == null) {
          Tower tempTower = new Tower(this.x+(round(random(-100, 100))), this.y+(round(random(-100, 100))));
          tempTower.id = 11;
          tempTower.updateTowerValues();
          tempTower.sprite = loadImage(dataPath("") + "/Towers/11.png");
          minions[i] = tempTower;
          minionSpawn = 100;
          break;
        }
      }
    }
  }

  private void updateMinions() {
    for (int i = 0; i < 3; i++) {
      if (minions[i] != null) {
        minions[i].update();
      }
    }
  }

  private void renderMinions() {
    for (int i = 0; i < 3; i++) {
      if (minions[i] != null) {
        minions[i].render();
      }
    }
  }

  private void updateMinionLife() {
    for (int i = 0; i < 3; i++) {
      if (minions[i] != null) {
        minions[i].minionLifeSpan--;
      }
    }
    spawnMinion();
    isMinionDead();
  }

  private void isMinionDead() {
    for (int i = 0; i < 3; i++) {
      if (minions[i] != null) {
        if (minions[i].minionLifeSpan <= 0) {
          minions[i] = null;
        }
      }
    }
  }
}
