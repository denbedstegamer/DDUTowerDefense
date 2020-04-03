public class Projectile{
  private PVector pos, dir;
  private int enemyId;
  private float vel;
  // damage stats and so on
  
  public Projectile(PVector pos, int enemyId){
    this.pos = pos;
    this.enemyId = enemyId;
  }
  
  public void update(){
    dir = game.level.track.points.get(enemyId).copy().sub(pos).copy().setMag(vel);
    pos.add(dir);
  }
  
  public void render(){
    /*
    imageMode(CENTER);
    image(sprite, pos.x, pos.y);*/
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(pos.x, pos.y, 10, 10);
  }
}
