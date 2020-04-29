public class Settings {
  private int life, startMoney, id;  // 0 = easy, 1 = normal, 2 = hard, 3 = sandbox
  private float healthMultiplier, priceMultiplier;

  public Settings(int id) {
    this.id = id;
    changeValues();
  }
  
  public void changeDifficulty(int id){
    this.id = id;
    changeValues();
  }

  private void changeValues() {
    switch(id) {
    case 0:
      life = 100;
      priceMultiplier = 0.5;
      healthMultiplier = 0.8;
      startMoney = 100;
      break;
    case 1:
      life = 1;
      priceMultiplier = 1;
      healthMultiplier = 1;
      startMoney = 80;
      break;
    case 2:
      life = 50;
      priceMultiplier = 1.5;
      healthMultiplier = 1.2;
      startMoney = 65;
      break;
    case 3:
      life = 10000;
      priceMultiplier = 0.1;
      healthMultiplier = 1;
      startMoney = 999999;
      break;
    }
  }
}
