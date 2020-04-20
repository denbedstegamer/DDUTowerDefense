public class Enemy {
  private PVector pos, dir;
  private int id, markCount = 0, life, radius = 10, totalLife, moneyOnKill, damageWhenGoalIsReached;
  private PImage sprite;
  private float vel, remainingLife;
  public boolean reachedGoal;

  public Enemy(int id, PVector pos) {
    this.id = id;
    //sprite = loadImage("Enemies/" + id + ".png");
    this.pos = pos.copy();
    dir = new PVector();
    setIDValues();
    totalLife = life;
  }

  public void setIDValues() {
    switch(id) {
      //normal enemy
    case 0:
      life = 30;
      vel = 1.5;
      moneyOnKill = 10;
      damageWhenGoalIsReached = 1;
      break;

      //bulky enemy
    case 1:
      life = 100;
      vel = 1.2;
      moneyOnKill = 20;
      damageWhenGoalIsReached = 2;
      break;

      //bulkiest enemy
    case 2:
      life = 400;
      vel = 0.8;
      moneyOnKill = 150;
      damageWhenGoalIsReached = 10;
      break;

      //speedy enemy
    case 3:
      life = 70;
      vel = 2.5;
      moneyOnKill = 15;
      damageWhenGoalIsReached = 2;
      break;

      //boss
    case 4:
      life = 4000;
      vel = 0.5;
      moneyOnKill = 500;
      damageWhenGoalIsReached = 95;
    }
  }

  public void update() {
    PVector dirTemp = game.level.track.points.get(markCount).copy().sub(pos).copy();
    if (dirTemp.mag() <= vel) {
      if (markCount < game.level.track.points.size()-1) {
        markCount++;
      } else {
        reachedGoal = true;
      }
    }
    dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(vel);
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
    //laver en rød healthbar under fjenden, med koordinater unden den, baseret på dens radius (så den uanset radius altid er under objektet)
    rect(pos.x-radius, pos.y+radius, radius*2, radius/3);
    fill(0, 255, 0);
    //samme som forrige, bare af propertionel størrelse med tilbageværende liv
    rect(pos.x-radius, pos.y+radius, radius*2*remainingLife, radius/3);
  }

  public void reduceLife(int damageTaken) {
    life = life - damageTaken;
  }

  public void givePlayerMoney() {
    game.player.addMoney(moneyOnKill);
  }

  public void dealDamageToPlayer() {
    game.player.takeDamage(damageWhenGoalIsReached);
  }
}
