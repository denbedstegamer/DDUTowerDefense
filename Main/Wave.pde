public class Wave {
  private int waveCount = 0, maxWaves = 10;
  private ArrayList<Enemy> enemies;

  public Wave() {
    enemies = new ArrayList<Enemy>();
    spawnEnemies = new Thread() {
      @Override
        public void run() {
        switch(waveCount) {
        case 0:
          for (int i = 0; i < 10; i++) {
            enemies.add(new Enemy(0, game.level.track.points.get(0)));
            try {
              sleep(1000);
            } 
            catch (Exception e) {
            }
          }
        }
      }
    };
  }

  public void update() {
    if (enemies.size() == 0) {
      spawnEnemies.run();
      waveCount++;
    }
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).update();
    }
    if (frameCount == 1200) {
      try {
        spawnEnemies.join();
      } 
      catch (Exception e) {
      }
    }
  }

  public void render() {
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).render();
    }
  }
}
