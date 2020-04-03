public class Projectile{
  private PVector pos, dir;
  private int enemyId;
  private float vel = 2;
  // damage stats and so on
  
  public Projectile(PVector pos, int enemyId){
    this.pos = pos;
    this.enemyId = enemyId;
  }
  
  public void update(){
    dir = game.wave.enemies.get(enemyId).pos.copy().sub(pos).copy().setMag(vel);
    pos.add(dir);
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
    rect(pos.x, pos.y, 10, 10);
  }
}
