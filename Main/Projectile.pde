public class Projectile{
  private PVector pos, dir;
  private int enemyId, radius, damage;
  private float vel = 3, distToEnemy;
  public boolean collided;
  // damage stats and so on
  
  public Projectile(PVector pos, int enemyId, int damage){
    this.pos = pos.copy();
    this.enemyId = enemyId;
    this.damage = damage;
    radius = 10;
  }
  
  public void update(){
    dir = game.wave.enemies.get(enemyId).pos.copy().sub(pos).copy().setMag(vel);
    pos.add(dir);
    detectCollision();
  }
  
  public void render(){
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
}
