public class Wave {
  public int waveCount = 0, maxWaves = 10, timeTillNextEnemy, timeSinceWaveStarted, enemyCount;
  private ArrayList<Enemy> enemies, queue;
  private ArrayList<Integer> queueTimes;

  public Wave() {
    enemies = new ArrayList<Enemy>();
    queue = new ArrayList<Enemy>();
    queueTimes = new ArrayList<Integer>();
  }

  public void spawnEnemies() {
    switch(waveCount) {
    case 0:
      timeTillNextEnemy = 60;
      for (int i = 0; i < 10; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }

    case 1:
      timeTillNextEnemy = 20;
      for (int i = 0; i < 10; i++) {
        queue.add(new Enemy(0, game.level.track.points.get(0)));
        queueTimes.add(timeTillNextEnemy);
      }
    }
  }

  public void update() {
    if (enemies.size() == 0) {
      queue.clear();
      queueTimes.clear();
      spawnEnemies();
      waveCount++;
      timeSinceWaveStarted = 0;
    }

    if (queue.size() != enemyCount) {
      if (timeSinceWaveStarted % queueTimes.get(enemyCount).intValue() == 0) {
        enemies.add(new Enemy(queue.get(enemyCount).id, queue.get(enemyCount).pos));
        enemyCount ++;
      }
    }

    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i) != null) {
        enemies.get(i).update();
      }
    }
    timeSinceWaveStarted ++;
    setEnemiesNull();
  }

  public void setEnemiesNull() {
    //fjerner døde fjender
    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i) != null) {
        //hvis fjender dør
        if (enemies.get(i).life <= 0) {
          //spilleren får penge for at dræbe fjenden
          enemies.get(i).givePlayerMoney();
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
