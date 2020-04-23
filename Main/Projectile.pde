public class Projectile {
  private PVector pos, dir, enemyStartPos;
  private int enemyId, radius, damage, id, lifeSpan;
  private float vel, distToEnemy;
  public boolean collided, homingProjectile, definedDirection = true;
  private PImage sprite;
  // damage stats and so on

  public Projectile(PVector pos, int enemyId, int id) {
    this.pos = pos.copy();
    this.enemyId = enemyId;
    this.id = id;
    enemyStartPos = game.wave.enemies.get(enemyId).pos.copy();
    giveProjectileVariables();
    radius = 10;

    sprite = loadImage(dataPath("") + "/Projectiles/" + id + ".png");
  }

  public void update() {
    if (enemyId < game.wave.enemies.size()) {
      if (game.wave.enemies.get(enemyId) != null) {
        if (homingProjectile) {
          homingProjectile();
        } else {
          nonHomingProjectile();
        }
      } else {
        collided = true;
      }
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
    if (game.wave.enemies.get(enemyId) != null) {
      distToEnemy = PVector.dist(pos, game.wave.enemies.get(enemyId).pos);
      if (distToEnemy < radius/2 + game.wave.enemies.get(enemyId).radius/2) {
        specializedProjectileEffect();
        game.wave.enemies.get(enemyId).reduceLife(damage);
        collided = true;
      }
    }
  }

  private void homingProjectile() {
    dir = game.wave.enemies.get(enemyId).pos.copy().sub(pos).copy().setMag(vel);
    pos.add(dir);
  }

  private void nonHomingProjectile() {
    if (definedDirection) {
      dir = enemyStartPos.sub(pos);
      println(dir.x, dir.y);
      definedDirection = false;
    }
    dir.setMag(vel);
    pos.add(dir);
  }

  private void giveProjectileVariables() {
    switch(id) {

      //peasant
    case 1:
      damage = 10;
      vel = 3;
      homingProjectile = true;
      break;

      //archer
    case 2:
      damage = 20;
      vel = 6;
      lifeSpan = 60;
      break;

      //knight
    case 3:
      damage = 30;
      break;

      //mage
    case 4:
      damage = 25;
      vel = 3;
      homingProjectile = true;
      break;

      //arrowflinger
    case 5:
      damage = 25;
      vel = 6;
      lifeSpan = 60;
      break;

      //sniper
    case 6:
      damage = 50;
      vel = 10;
      lifeSpan = 9999;
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
      homingProjectile = true;
      break;

      //archmage
    case 10:
    case 11:
    case 12:
      damage = 35;
      vel = 5;
      homingProjectile = true;
      break;
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
