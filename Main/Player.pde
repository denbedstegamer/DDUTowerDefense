public class Player{
  private int life, MONEY;
  
  public Player(){
    
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
}
