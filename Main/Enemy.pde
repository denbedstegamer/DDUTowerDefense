public class Enemy {
  private PVector pos, dir;
  private int id, markCount = 0, life, radius = 18, totalLife, moneyOnKill, damageWhenGoalIsReached, burnDamage, slowTime, burnTime, stunTime;
  private PImage sprite;
  private float vel, remainingLife, slowPercent;
  private int frame;
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
      if (game.wave.waveCount < 10) {
        life = 30;
        vel = 1.5;
        moneyOnKill = 6;
        damageWhenGoalIsReached = 1;
      } else {
        life = 50+(game.wave.waveCount*2);
        vel = 1.5;
        moneyOnKill = 0;
        damageWhenGoalIsReached = 2;
      }
      break;

      //bulky enemy
    case 1:
    if (game.wave.waveCount < 8) {
      life = 100;
      vel = 1.2;
      moneyOnKill = 6;
      damageWhenGoalIsReached = 4;
    } 
    if (game.wave.waveCount < 10) {
      life = 100;
      vel = 1.2;
      moneyOnKill = 4;
      damageWhenGoalIsReached = 4;
    }else{
      life = 100+(game.wave.waveCount*5);
      vel = 1.2;
      moneyOnKill = 1;
      damageWhenGoalIsReached = 10;
    }
      break;

      //bulkiest enemy
    case 2:
    if (game.wave.waveCount < 10) {
      life = 300;
      vel = 1;
      moneyOnKill = 4;
      damageWhenGoalIsReached = 10;
    } else{
      life = 300+(game.wave.waveCount*10);
      vel = 1;
      moneyOnKill = 2;
      damageWhenGoalIsReached = 20;
    }
      break;

      //speedy enemy
    case 3:
    if (game.wave.waveCount < 10) {
      life = 100;
      vel = 2.8;
      moneyOnKill = 10;
      damageWhenGoalIsReached = 6;
    } else{
      life = 100+(game.wave.waveCount*5);
      vel = 2.8+(game.wave.waveCount/100);
      moneyOnKill = round(10-(game.wave.waveCount/2));
      damageWhenGoalIsReached = 10;
    }
      break;

      //boss
    case 4:
      life = 7000+(game.wave.waveCount*100);
      vel = 1;
      moneyOnKill = 30;
      damageWhenGoalIsReached = 100;
      break;

      //dragon
    case 5:
      life = 25000;
      vel = 1.3;
      moneyOnKill = 10000;
      damageWhenGoalIsReached = 999;
      break;
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
    if (burnTime > 0) {
      if (burnTime % 60 == 0) {
        reduceLife(burnDamage);
      }
      burnTime--;
    }
    if (stunTime > 0) {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(0.001);
      stunTime--;
    } else if (slowTime > 0) {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(vel*slowPercent);
      slowTime--;
    } else {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(vel);
    }
    pos.add(dir);
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
      tint(255, 0, 255);
    } else if (burnTime > 0) {
      tint(255, 0, 0);
    } else if (slowTime > 0) {
      tint(0, 0, 255);
    }
    if (id == 5) {
      frame ++;
      if (frame >= 0 && frame < 18) {
        sprite = loadImage(dataPath("") + "/Enemies/" + (id+0) + ".png");
      } else if (frame >= 18 && frame < 36) {
        sprite = loadImage(dataPath("") + "/Enemies/" + (id+1) + ".png");
      } else {
        sprite = loadImage(dataPath("") + "/Enemies/" + (id+2) + ".png");
      }
      if (frame == 54) {
        frame = 0;
      }
    }
    image(sprite, 0, 0);
    noTint();
    popMatrix();
    renderHealthbar();
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
    if (life <= 0) {
      onDeath();
    }
  }

  public void givePlayerMoney() {
    game.player.addMoney(moneyOnKill);
  }

  public void dealDamageToPlayer() {
    game.player.takeDamage(damageWhenGoalIsReached);
  }

  private void onDeath() {
    switch(id) {
      //normal enemy
    case 0:
      break;

      //bulky enemy
    case 1:
      break;

      //bulkiest enemy
    case 2:
      PVector temp = new PVector(25, 0);
      for (int i = 0; i < 2; i++) {
        Enemy tempEnemy = new Enemy(1, pos.copy().add(temp));
        game.wave.enemies.add(tempEnemy);
        for (int j = 0; j < game.wave.enemies.size(); j++) {
          if (game.wave.enemies.get(j) != null) {
            if (game.wave.enemies.get(j).equals(tempEnemy)) {
              game.wave.enemies.get(j).markCount = markCount;
            }
          }
        }
        temp.rotate(PI*2/5);
      }
      break;

      //speedy enemy
    case 3:
    temp = new PVector(25, 0);
    if(game.wave.waveCount > 10){
      for (int i = 0; i < 2; i++) {
        Enemy tempEnemy = new Enemy(1, pos.copy().add(temp));
        game.wave.enemies.add(tempEnemy);
        for (int j = 0; j < game.wave.enemies.size(); j++) {
          if (game.wave.enemies.get(j) != null) {
            if (game.wave.enemies.get(j).equals(tempEnemy)) {
              game.wave.enemies.get(j).markCount = markCount;
            }
          }
        }
        temp.rotate(PI*2/5);
      }
    }
      break;

      //boss
    case 4:
      temp = new PVector(25, 0);
      for (int i = 0; i < 5; i++) {
        Enemy tempEnemy = new Enemy(2, pos.copy().add(temp));
        game.wave.enemies.add(tempEnemy);
        for (int j = 0; j < game.wave.enemies.size(); j++) {
          if (game.wave.enemies.get(j) != null) {
            if (game.wave.enemies.get(j).equals(tempEnemy)) {
              game.wave.enemies.get(j).markCount = markCount;
            }
          }
        }
        temp.rotate(PI*2/5);
      }
      break;
    }
  }
}
