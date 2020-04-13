public class Wave {
  private int waveCount = 0, maxWaves = 10, timeTillNextEnemy, timeSinceWaveStarted, enemyCount;
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
      enemies.get(i).update();
    }
    timeSinceWaveStarted ++;
  }

  public void render() {
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).render();
    }
  }
}
