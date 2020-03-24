public class Tower{
  // texture and id/type
  private int x, y, radius = 20;  //måske d ikkr r
  
  public Tower(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public void render(){
    strokeWeight(1);
    fill(0, 255, 0);
    ellipse(x, y, radius*2, radius*2);
  }
  
  public int getRadius(){
    return radius;
  }
  
  public int getX(){
    return x;
  }
  public int getY(){
    return y;
  }
}
