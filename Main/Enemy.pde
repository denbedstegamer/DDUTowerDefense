public class Enemy {
  private PVector pos, dir;
  private int id, markCount = 0, life, radius = 10, totalLife;
  private PImage sprite;
  private float vel, remainingLife;

  public Enemy(int id, PVector pos) {
    this.id = id;
    sprite = loadImage("Enemies/" + id + ".png");
    this.pos = pos.copy();
    dir = new PVector();
    setIDValues();
    totalLife = life;
  }
  
  public void setIDValues() {
    switch(id) {
      //normal enemy
      case 0:
        life = 100;
        vel = 1.5;
        break;
        
        //bulky enemy
        case 1:
        life = 200;
        vel = 1.2;
        break;
        
        //bulkiest enemy
        case 2:
        life = 400;
        vel = 0.8;
        break;
        
        //speedy enemy
        case 3:
        life = 150;
        vel = 2.5;
        break;
    }
  }

  public void update() {
    PVector dirTemp = game.level.track.points.get(markCount).copy().sub(pos).copy();
    if (dirTemp.mag() <= vel) {
      markCount++;
    }
    if (game.level.track.points.get(markCount) == null) {
      // do something with life thing idk
    } else {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(vel);
    }
    pos.add(dir);
  }

  public void render() {
    /*
    imageMode(CENTER);
     image(sprite, pos.x, pos.y);*/
    stroke(0);
    strokeWeight(1);
    fill(0, 0, 255);
    rectMode(CENTER);
    rect(pos.x, pos.y, radius, radius);
    renderHealthbar();
  }
  
  public void renderHealthbar() {
    remainingLife = (life+0.0)/(totalLife+0.0);
    strokeWeight(0);
    rectMode(CORNER);
    fill(255, 0, 0);
    //laver en rød healthbar under fjenden, med koordinater uden den, baseret på dens radius (så den uanset radius altid er under objektet)
    rect(pos.x-radius, pos.y+radius, radius*2, radius/3);
    fill(0, 255, 0);
    //samme som forrige, bare af propertionel størrelse med tilbageværende liv
    rect(pos.x-radius, pos.y+radius, radius*2*remainingLife, radius/3);
  }
  
  public void reduceLife(int damageTaken) {
    life = life - damageTaken;
  }
}
