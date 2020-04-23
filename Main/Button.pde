public class Button {
  private PVector pos, size;
  private String text, text2, text3;

  // it's "width_" and not "width", because width is already defined because of processing and therefore it can't be used.
  public Button(float x, float y, float width_, float height_, String text, String text2, String text3) {
    pos = new PVector(x, y);
    size = new PVector(width_, height_);
    this.text = text;
    this.text2 = text2;
    this.text3 = text3;
  }

  public void render() {
    strokeWeight(1);
    stroke(0);
    rectMode(CORNER);
    fill(200);
    rect(pos.x, pos.y, size.x, size.y);
    
    textSize(60);
    textAlign(CENTER);
    fill(0);
    text(text, pos.x+size.x/2, pos.y+size.y/3*2);
    textSize(50);
    text(text2, pos.x+size.x/2, pos.y+size.y/2);
    textSize(30);
    text(text3, pos.x+size.x/2, pos.y+size.y/2);
  }

  public void pressed() {
    if (mousePressed == true && mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y) {
      action();
    }
  }
  
  public void action() {}
}
