public class Projectile {
  private PVector pos, dir;
  private int enemyId, radius, damage, towerId;
  private float vel, distToEnemy;
  public boolean collided;
  // damage stats and so on

  public Projectile(PVector pos, int enemyId, int towerId) {
    this.pos = pos.copy();
    this.enemyId = enemyId;
    this.towerId = towerId;
    giveProjectileVariables();
    radius = 10;
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
        specializedProjectileEffect();
        game.wave.enemies.get(enemyId).reduceLife(damage);
        collided = true;
      }
    }
  }

  private void giveProjectileVariables() {
    switch(towerId) {
      
      //peasant
    case 1:
      damage = 10;
      vel = 3;
      break;

      //archer
    case 2:
      damage = 20;
      vel = 4;
      break;

      //knight
    case 3:
      damage = 30;
      break;

      //mage
    case 4:
      damage = 25;
      vel = 3;
      break;

      //arrowflinger
    case 5:
      damage = 25;
      vel = 6;
      break;

      //sniper
    case 6:
      damage = 50;
      vel = 10;
      break;

      //barbarian
    case 7:
      damage = 30;
      break;

      //king
    case 8:
      damage = 40;
      break;

      //summoner
    case 9:
      damage = 10;
      vel = 4;
      break;

      //archmage
    case 10:
    case 11:
    case 12:
      damage = 35;
      vel = 5;
      break;
    }
  }

  public void specializedProjectileEffect() {
    switch(towerId) {
      //frostbolt
    case 10:
      game.wave.enemies.get(enemyId).slowTime = 180;
      break;
      //fireball
    case 11:
      game.wave.enemies.get(enemyId).burnTime = 240;
      break;
      //lightningbolt
    case 12:
      game.wave.enemies.get(enemyId).stunTime = 30;
      break;
    }
  }
}
