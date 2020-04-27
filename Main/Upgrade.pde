public class Upgrade{
  private String name;
  private int id;
  private float cost;
  
  public Upgrade(String name, int id, float cost){
    this.id = id;
    this.name = name;
    this.cost = cost * game.priceMultiplier;
  }
  
  public Upgrade(Upgrade u){
    this.id = u.id;
    this.name = u.name;
    this.cost = u.cost;
  }
  
  public String getName(){
    return name;
  }
  
  public int getId(){
    return id;
  }
  
  public float getCost(){
    return cost;
  }
}
