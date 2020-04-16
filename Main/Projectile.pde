public class Projectile {
  private PVector pos, dir;
  private int enemyId, radius, damage, towerId;
  private float vel = 3, distToEnemy;
  public boolean collided;
  // damage stats and so on

  public Projectile(PVector pos, int enemyId, int damage, int towerId) {
    this.pos = pos.copy();
    this.enemyId = enemyId;
    this.damage = damage;
    this.towerId = towerId;
    radius = 10;
  }

  public void update() {
    if (game.wave.enemies.get(enemyId) != null) {
      dir = game.wave.enemies.get(enemyId).pos.copy().sub(pos).copy().setMag(vel);
    } else {
      collided = true;
    }
    pos.add(dir);
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
    distToEnemy = PVector.dist(pos, game.wave.enemies.get(enemyId).pos);
    if (distToEnemy < radius/2 + game.wave.enemies.get(enemyId).radius/2) {
      game.wave.enemies.get(enemyId).reduceLife(damage);
      collided = true;
    }
  }


  public void addEffect() {
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
}
