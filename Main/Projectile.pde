public class Projectile {
  private PVector pos, dir;
  private int enemyId, radius, damage, towerId, cycle;
  private float vel = 3, distToEnemy;
  public boolean collided;
  // damage stats and so on

  public Projectile(PVector pos, int enemyId, int damage, int towerId) {
    this.pos = pos.copy();
    this.enemyId = enemyId;
    this.damage = damage;
    this.towerId = towerId;
    radius = 10;
    cycle = 1;
  }

  public void update() {
    if (game.wave.enemies.get(enemyId) != null) {
      dir = game.wave.enemies.get(enemyId).pos.copy().sub(pos).copy().setMag(vel);
      pos.add(dir);
    } else {
      collided = true;
    }
    detectCollision();
  }

  public void render() {
    /*
    HUSK ROTATION
     imageMode(CENTER);
     image(sprite, pos.x, pos.y);*/
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(pos.x, pos.y, radius, radius);
  }

  private void detectCollision() {
    if (game.wave.enemies.get(enemyId) != null) {
      distToEnemy = PVector.dist(pos, game.wave.enemies.get(enemyId).pos);
      if (distToEnemy < radius/2 + game.wave.enemies.get(enemyId).radius/2) {
        game.wave.enemies.get(enemyId).reduceLife(damage);
        collided = true;
      }
    }
  }

  private void giveProjectileVariables() {
    switch(towerId) {

      //peasant
    case 1:

      break;

      //archer
    case 2:

      break;

      //knight
    case 3:

      break;

      //mage
    case 4:

      break;

      //arrowflinger
    case 5:

      break;

      //sniper
    case 6:

      break;

      //barbarian
    case 7:

      break;

      //king
    case 8:

      break;

      //summoner
    case 9:

      break;

      //archmage
    case 10:

      break;
    }
  }

  public void specializedProjectileEffect() {
    if (towerId == 10) {
      switch(cycle) {
        //frostbolt
      case 1:
      game.wave.enemies.get(enemyId).slowTime = 180;
      break;
        //fireball
      case 2:
      game.wave.enemies.get(enemyId).burnTime = 240;
      break;
        //lightningbolt
      case 3:
      game.wave.enemies.get(enemyId).stunTime = 30;
      break;
      }
    }
  }
}
