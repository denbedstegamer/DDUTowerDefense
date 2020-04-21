public class Player{
  private int life, MONEY;
  public boolean dead;
  
  public Player(){
    this.life = 100;
    this.MONEY = 5000;
  }
  
  public int getLife(){
    return life;
  }
  
  public int getMoney(){
    return MONEY;
  }
  
  public void addMoney(int money) {
    MONEY += money;
  }
  
  public void takeDamage(int damage) {
    life -= damage;
  }
  
  public void updatePlayerStatus() {
    if(life >= 0) {
      dead = true;
    }
  }
}
