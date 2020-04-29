public class Wave {
  public int waveCount = 10, maxWaves = 10, timeTillNextEnemy, timeSinceWaveStarted, enemyCount, totalEnemiesCount;
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
      totalEnemiesCount = 10;
      timeTillNextEnemy = 60;
      for (int i = 0; i < 10; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 2
    case 2:
      totalEnemiesCount = 14;
      timeTillNextEnemy = 20;
      for (int i = 0; i < 14; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 3
    case 3:
      totalEnemiesCount = 8;
      timeTillNextEnemy = 80;
      for (int i = 0; i < 8; i++) {
        queue.add(new Enemy(1, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 4
    case 4:
      totalEnemiesCount = 16;
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
      totalEnemiesCount = 5;
      timeTillNextEnemy = 100;
      for (int i = 0; i < 5; i++) {
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 6
    case 6:
      totalEnemiesCount = 25;
      timeTillNextEnemy = 40;
      for (int i = 0; i < 25; i++) {
        queue.add(new Enemy(3, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 7
    case 7:
      totalEnemiesCount = 20;
      for (int i = 0; i < 4; i++) {
        timeTillNextEnemy = 300;
        queue.add(new Enemy(2, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
        for (int j = 0; j < 4; j++) {
          timeTillNextEnemy = 20;
          queue.add(new Enemy(3, game.level.track.points.get(0)));
          queueTimes.add(timeTillNextEnemy);
        }
      }
      break;

      //wave 8
    case 8:
      totalEnemiesCount = 20;
      timeTillNextEnemy = 20;
      for (int i = 0; i < 20; i++) {
        queue.add(new Enemy(1, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 9
    case 9:
      totalEnemiesCount = 30;
      timeTillNextEnemy = 20;
      for (int i = 0; i < 30; i++) {
        queue.add(new Enemy(3, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
      break;

      //wave 10
    case 10:
      totalEnemiesCount = 1;
      timeTillNextEnemy = 1;
      queue.add(new Enemy(4, game.level.track.points.get(0)));
      queueTimes.add(timeTillNextEnemy);
      break;
    }
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
    if (temp && enemyCount == totalEnemiesCount && timeSinceWaveStarted >= 2) {
      enemies.clear();
    }
    if (enemies.size() == 0) {
      queue.clear();
      queueTimes.clear();
      waveCount++;
      game.projectiles.clear();
      timeSinceWaveStarted = 0;
      game.gaming = false;
      game.player.addMoney(10+waveCount*5);
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
