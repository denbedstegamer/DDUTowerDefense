public class Wave {
  public int waveCount = 1, maxWaves = 20, timeTillNextEnemy, timeSinceWaveStarted, enemyCount, totalEnemiesCount;
  private ArrayList<Enemy> enemies, queue;
  private ArrayList<Integer> queueTimes;

  public Wave() {
    enemies = new ArrayList<Enemy>();
    queue = new ArrayList<Enemy>();
    queueTimes = new ArrayList<Integer>();
  }

  public void spawnEnemies() {
    switch(waveCount) {

      //wave 1
    case 1:
      timeTillNextEnemy = 60;
      for (int i = 0; i < 10; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 2
    case 2:
      timeTillNextEnemy = 20;
      for (int i = 0; i < 14; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 3
    case 3:
      timeTillNextEnemy = 80;
      for (int i = 0; i < 8; i++) {
        queue.add(new Enemy(1, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 4
    case 4:
      timeTillNextEnemy = 40;
      for (int i = 0; i < 8; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
        queue.add(new Enemy(1, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 5
    case 5:
      timeTillNextEnemy = 100;
      for (int i = 0; i < 5; i++) {
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 6
    case 6:
      timeTillNextEnemy = 40;
      for (int i = 0; i < 18; i++) {
        queue.add(new Enemy(3, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 7
    case 7:
      for (int i = 0; i < 5; i++) {
        timeTillNextEnemy = 60;
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      queueTimes.add(450);
      for (int j = 0; j < 12; j++) {
          timeTillNextEnemy = 35;
          queue.add(new Enemy(3, game.level.track.points.get(0)));
          queueTimes.add(timeTillNextEnemy);
        }
      break;

      //wave 8
    case 8:
      timeTillNextEnemy = 20;
      for (int i = 0; i < 20; i++) {
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 9
    case 9:
      timeTillNextEnemy = 20;
      for (int i = 0; i < 30; i++) {
        queue.add(new Enemy(3, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 10
    case 10:
      timeTillNextEnemy = 1;
      queue.add(new Enemy(4, game.level.track.points.get(0)));
      queueTimes.add(timeTillNextEnemy);
      break;

      //wave 11
    case 11:
      for (int i = 0; i < 8; i++) {
        timeTillNextEnemy = 60;
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
        for (int j = 0; j < 8; j++) {
          timeTillNextEnemy = 10;
          queue.add(new Enemy(3, game.level.track.points.get(0)));
          queueTimes.add(timeTillNextEnemy);
        }
      }
      break;

      //wave 12
    case 12:
      for (int i = 0; i < 30; i++) {
        timeTillNextEnemy = 30;
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
        for (int j = 0; j < 8; j++) {
          timeTillNextEnemy = 5;
          queue.add(new Enemy(3, game.level.track.points.get(0)));
          queueTimes.add(timeTillNextEnemy);
        }
      }
      break;

      //wave 13
    case 13:
      timeTillNextEnemy = 500;
      for (int i = 0; i < 2; i++) {
        queue.add(new Enemy(4, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 14
    case 14:
      timeTillNextEnemy = 2;
      for (int i = 0; i < 100; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
        queue.add(new Enemy(1, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 15
    case 15:
      timeTillNextEnemy = 2;
      for (int i = 0; i < 100; i++) {
        queue.add(new Enemy(3, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 16
    case 16:
      timeTillNextEnemy = 200;
      for (int i = 0; i < 3; i++) {
        queue.add(new Enemy(4, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 17
    case 17:
      for (int i = 0; i < 2; i++) {
        timeTillNextEnemy = 120;
        queue.add(new Enemy(4, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
        for (int j = 0; j < 50; j++) {
          timeTillNextEnemy = 4;
          queue.add(new Enemy(3, game.level.track.points.get(0)));
          queueTimes.add(timeTillNextEnemy);
        }
      }
      break;

      //wave 18
    case 18:
      timeTillNextEnemy = 5;
      for (int i = 0; i < 50; i++) {
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 19
    case 19:
      timeTillNextEnemy = 300;
      for (int i = 0; i < 5; i++) {
        queue.add(new Enemy(4, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 20
    case 20:
      timeTillNextEnemy = 60;
      queue.add(new Enemy(5, game.level.track.points.get(0)));
      queueTimes.add(timeTillNextEnemy);
      break;
    }
    totalEnemiesCount = queue.size();
  }

  public void update() {
    if (queue.size() != enemyCount) {
      if (timeSinceWaveStarted % queueTimes.get(enemyCount).intValue() == 0) {
        enemies.add(new Enemy(queue.get(enemyCount).id, queue.get(enemyCount).pos));
        enemyCount ++;
      }
    }
    setEnemiesNull();
    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i) != null) {
        enemies.get(i).update();
      }
    }
    timeSinceWaveStarted ++;

    boolean temp = true;
    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i) != null) {
        temp = false;
      }
    }
    boolean allEnemiesDead = true;
    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i) != null) {
        allEnemiesDead = false;
      }
    }
    if (temp && enemyCount == totalEnemiesCount && timeSinceWaveStarted >= 2 && allEnemiesDead) {
      enemies.clear();
    }
    if (enemies.size() == 0) {
      queue.clear();
      queueTimes.clear();
      waveCount++;
      game.projectiles.clear();
      timeSinceWaveStarted = 0;
      game.gaming = false;
      //Give player money on round end
      if (waveCount <= 10) {
        game.player.addMoney(20+waveCount);
      } else {
        game.player.addMoney(30);
      }
      enemyCount = 0;
    }
  }

  public void setEnemiesNull() {
    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i) != null) {
        //hvis fjendens liv er lig nul, køres for-loopet
        if (enemies.get(i).life <= 0) {
          //spilleren får penge for at dræbe fjenden
          enemies.get(i).givePlayerMoney();
          enemies.set(i, null);
        } else if (enemies.get(i).reachedGoal) {
          enemies.get(i).dealDamageToPlayer();
          enemies.set(i, null);
        }
      }
    }
  }

  public void render() {
    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i) != null) {
        enemies.get(i).render();
      }
    }
  }
}
