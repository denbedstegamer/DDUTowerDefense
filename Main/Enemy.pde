public class Enemy {
  private PVector pos, dir;
  private int id, markCount = 0, life, radius = 30, totalLife, moneyOnKill, damageWhenGoalIsReached, burnDamage, slowTime, burnTime, stunTime;
  private PImage sprite;
  private float vel, remainingLife, slowPercent;
  public boolean reachedGoal;

  public Enemy(int id, PVector pos) {
    this.id = id;
    sprite = loadImage(dataPath("") + "/Enemies/" + id + ".png");
    this.pos = pos.copy();
    dir = new PVector();
    setIDValues();
    life *= game.healthMultiplier;
    totalLife = life;
    burnDamage = 10;
    slowPercent = 0.8;
  }

  public void setIDValues() {
    switch(id) {
      //normal enemy
    case 0:
      life = 30;
      vel = 1.5;
      moneyOnKill = 6;
      damageWhenGoalIsReached = 1;
      break;

      //bulky enemy
    case 1:
      life = 100;
      vel = 1.2;
      moneyOnKill = 8;
      damageWhenGoalIsReached = 4;
      break;

      //bulkiest enemy
    case 2:
      life = 400;
      vel = 1;
      moneyOnKill = 12;
      damageWhenGoalIsReached = 10;
      break;

      //speedy enemy
    case 3:
      life = 100;
      vel = 3;
      moneyOnKill = 12;
      damageWhenGoalIsReached = 2;
      break;

      //boss
    case 4:
      life = 5;
      vel = 0.8;
      moneyOnKill = 5000;
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
    if (stunTime > 0) {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(0.001);
    } else if (slowTime > 0) {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(vel*slowPercent);
    } else {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(vel);
    }
    pos.add(dir);

    if (slowTime > 0) {
      slowTime--;
    }

    if (burnTime > 0) {
      if (burnTime % 60 == 0) {
        reduceLife(burnDamage);
      }
      burnTime--;
    }

    if (stunTime > 0) {
      stunTime--;
    }
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
    if (burnTime > 0 && slowTime > 0) {
      tint(255,0,255);
    } else if (burnTime > 0) {
      tint(255,0,0);
    } else if (slowTime > 0) {
      tint(0,0,255);
    }
    image(sprite, 0, 0);
    noTint();
    popMatrix();
    renderHealthbar();

    /*stroke(0);
     strokeWeight(1);
     fill(0, 0, 255);
     rectMode(CENTER);
     rect(pos.x, pos.y, radius, radius);
     renderHealthbar();*/
  }

  public void renderHealthbar() {
    remainingLife = (life+0.0)/(totalLife+0.0);
    if (remainingLife < 0) {
      remainingLife = 0;
    }
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
