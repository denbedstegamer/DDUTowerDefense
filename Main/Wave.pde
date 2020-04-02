public class Wave {
  private int waveCount = 0, maxWaves = 10;
  private ArrayList<Enemy> enemies;

  public Wave() {
    enemies = new ArrayList<Enemy>();
  }

  private void spawnWave(){
    switch(waveCount){
      case 0:
      enemies.add(new Enemy(0, game.level.track.points.get(0)));
    }
  }
  
  public void update() {
    if(enemies.size() == 0){
      spawnWave();
      waveCount++;
    }
    for(int i = 0; i < enemies.size(); i++){
      enemies.get(i).update();
    }
  }
  
  public void render(){
    for(int i = 0; i < enemies.size(); i++){
      enemies.get(i).render();
    }
  }
}
