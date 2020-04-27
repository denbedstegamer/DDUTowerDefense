public class Player{
  private int life;
  private float money;
  
  public Player(int life, float money){
    this.life = life;
    this.money = money;
  }
  
  public int getLife(){
    return life;
  }
  
  public float getMoney(){
    return money;
  }
  
  public void addMoney(float money) {
    this.money += money;
  }
  
  public void takeDamage(int damage) {
    life -= damage;
  }
}
