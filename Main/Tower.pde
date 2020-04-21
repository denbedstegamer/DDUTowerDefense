public class Tower {
  // texture and id/type
  private int x, y, radius = 20;  //måske d ikkr r
  private int range, damage, as, id, targetEnemy;  // as = Attack Speed
  private PVector pos;
  private PImage sprite;

  public Tower(int x, int y) {
    this.x = x;
    this.y = y;
    pos = new PVector(x, y);
    id = 1;
    updateTowerValues();
  }

  public void update() {
    if (frameCount % (as*5) == 0) {
      attack();
    }
  }

  public void render() {
    ellipseMode(CENTER);
    stroke(0);
    strokeWeight(1);
    fill(0, 255, 0);
    ellipse(x, y, radius*2, radius*2);
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
      damage = 10;
      as = 10;
      range = 100;
      break;

      //archer
    case 2:
      damage = 20;
      as = 7;
      range = 250;
      break;

      //knight
    case 3:
      damage = 30;
      as = 5;
      range = 50;
      break;

      //mage
    case 4:
      damage = 25;
      as = 13;
      range = 200;
      break;

      //arrowflinger
    case 5:
      damage = 25;
      as = 5;
      range = 300;
      break;

      //sniper
    case 6:
      damage = 50;
      as = 15;
      range = 10000;
      break;

      //barbarian
    case 7:
      damage = 30;
      as = 2;
      range = 50;
      break;

      //king
    case 8:
      damage = 40;
      as = 5;
      range = 100;
      break;

      //summoner
    case 9:
      damage = 10;
      as = 11;
      range = 250;
      break;

      //archmage
    case 10:
      damage = 35;
      as = 5;
      range = 300;
      break;
    }
  }

  public void upgrade(int id) {
    this.id = id;
    updateTowerValues();
  }

  public ArrayList<Upgrade> getUpgrades() {
    ArrayList<Upgrade> upgrades = new ArrayList<Upgrade>();
    switch(id) {
    case 1:
      upgrades.add(new Upgrade("Archer", 2, 10));
      upgrades.add(new Upgrade("Knight", 3, 50));
      upgrades.add(new Upgrade("Mage", 4, 100));
      break;

    case 2:
      upgrades.add(new Upgrade("ArrowFlinger", 5, 100));
      upgrades.add(new Upgrade("Sniper", 6, 100));
      break;
      
    case 3:
      upgrades.add(new Upgrade("Barbarian", 7, 100));
      upgrades.add(new Upgrade("King", 8, 100));
      break;
      
    case 4:
      upgrades.add(new Upgrade("Summoner", 9, 100));
      upgrades.add(new Upgrade("Archmage", 10, 100));
      break;
    }
    return upgrades;
  }

  private void spotEnemy() {
    for (int i = 0; i < game.wave.enemies.size(); i++) {
      if (game.wave.enemies.get(i) != null) {
        if (PVector.dist(pos, game.wave.enemies.get(i).pos) < range) {
          targetEnemy = i;
          break;
        } else {
          targetEnemy = -1;
        }
      }
    }
  }

  private void attack() {
    spotEnemy();
    if (targetEnemy != -1) {    
      game.projectiles.add(new Projectile(pos, targetEnemy, damage, id));
    }
  }

  //skal sørge for at hver tårns unikke effekt kommer i spil
  private void addTowerEffect() {
  }
}
