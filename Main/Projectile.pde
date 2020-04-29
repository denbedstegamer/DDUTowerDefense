public class Projectile {
  private PVector pos, dir, enemyStartPos;
  private int enemyId, radius, damage, id;
  private float vel, distToEnemy;
  public boolean collided, homingProjectile, definedDirection = false;
  private PImage sprite;
  // damage stats and so on

  public Projectile(PVector pos, int enemyId, int id) {
    this.pos = pos.copy();
    this.enemyId = enemyId;
    this.id = id;
    giveProjectileVariables();
    radius = 10;

    sprite = loadImage(dataPath("") + "/Projectiles/" + id + ".png");
  }

  public Projectile(PVector pos, PVector dir, int id) {
    this.pos = pos.copy();
    this.id = id;
    this.dir = dir;
    definedDirection = true;
    giveProjectileVariables();
    radius = 10;

    sprite = loadImage(dataPath("") + "/Projectiles/" + id + ".png");
  }

  public void update() {
    if (homingProjectile) {
      if (enemyId < game.wave.enemies.size()) {
        if (game.wave.enemies.get(enemyId) != null) {
          if (homingProjectile) {
            homingProjectile();
          }
        } else {
          collided = true;
        }
      }
    } else {
      nonHomingProjectile();
    }
    detectCollision();
  }

  public void render() {
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
  }

  private void detectCollision() {
    if (homingProjectile) {
      if (game.wave.enemies.get(enemyId) != null) {
        distToEnemy = PVector.dist(pos, game.wave.enemies.get(enemyId).pos);
        if (distToEnemy < radius/2 + game.wave.enemies.get(enemyId).radius/2) {
          specializedProjectileEffect();
          game.wave.enemies.get(enemyId).reduceLife(damage);
          collided = true;
        }
      }
    } else {
      for (int i = 0; i < game.wave.enemies.size(); i++) {
        if (game.wave.enemies.get(i) != null) {
          distToEnemy = PVector.dist(pos, game.wave.enemies.get(i).pos);
          if (distToEnemy < radius/2 + game.wave.enemies.get(i).radius/2) {
            game.wave.enemies.get(i).reduceLife(damage);
            collided = true;
          }
        }
      }
    }
  }

  private void homingProjectile() {
    dir = game.wave.enemies.get(enemyId).pos.copy().sub(pos).copy().setMag(vel);
    pos.add(dir);
  }

  private void nonHomingProjectile() {
    if (!definedDirection) {
      dir = enemyStartPos.sub(pos);
      definedDirection = true;
    }
    dir.setMag(vel);
    pos.add(dir);
  }

  private void giveProjectileVariables() {
    switch(id) {

      //peasant
    case 1:
      damage = 12;
      vel = 3;
      homingProjectile = true;
      break;

      //archer
    case 2:
      damage = 10;
      vel = 16;
      break;

      //mage
    case 4:
      damage = 24;
      vel = 3;
      homingProjectile = true;
      break;

      //arrowflinger
    case 5:
      damage = 12;
      vel = 14;
      break;

      //sniper
    case 6:
      damage = 40;
      vel = 50;
      break;

      //summoner
    case 9:
      damage = 10;
      vel = 4;
      homingProjectile = true;
      break;

      //archmage
    case 10:
    case 11:
    case 12:
      damage = 24;
      vel = 7;
      homingProjectile = true;
      break;
      
      //void summon
    case 111:
      damage = 10;
      vel = 5;
      homingProjectile = true;
      break;
      
      //Knight line damage in Tower class
    }
  }

  public void specializedProjectileEffect() {
    switch(id) {
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
      game.wave.enemies.get(enemyId).stunTime = 5;
      break;
    }
  }
}
