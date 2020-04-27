public class Settings {
  private int life, startMoney, priceMultiplier, id;  // 0 = easy, 1 = normal, 2 = hard
  private float healthMultiplier;

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
      priceMultiplier = 1;
      healthMultiplier = 1;
      startMoney = 100;
      break;
    case 1:
      life = 75;
      priceMultiplier = 2;
      healthMultiplier = 1.5;
      startMoney = 80;
      break;
    case 2:
      life = 50;
      priceMultiplier = 3;
      healthMultiplier = 2.5;
      startMoney = 65;
      break;
    }
  }
}
