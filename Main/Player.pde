public class Player{
  private int life, money;
  public boolean dead;
  
  public Player(int life, int money){
    this.life = life;
    this.money = money;
  }
  
  public int getLife(){
    return life;
  }
  
  public int getMoney(){
    return money;
  }
  
  public void addMoney(int money) {
    this.money += money;
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
