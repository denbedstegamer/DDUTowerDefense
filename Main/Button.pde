public class Button {
  private PVector pos, size;
  private String text;

  // it's "width_" and not "width", because width is already defined because of processing and therefore it can't be used.
  public Button(float x, float y, float width_, float height_, String text) {
    pos = new PVector(x, y);
    size = new PVector(width_, height_);
    this.text = text;
  }

  public void render() {
    stroke(1);
    rectMode(CORNER);
    fill(200);
    rect(pos.x, pos.y, size.x, size.y);
    
    textSize(64);
    textAlign(CENTER);
    fill(255);
    text(text, pos.x+size.x/2, pos.y+size.y/3*2);
  }

  public void pressed() {
    if (mousePressed == true && mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y) {
      action();
    }
  }
  
  public void action() {}
}
