public class FieldPiece {
  private int x, y;
  private boolean isEmpty;
  
  // måske ingen farve
  private color c;

  public FieldPiece(int x, int y, boolean isEmpty) {
    this.x = x;
    this.y = y;
    this.isEmpty = isEmpty;
    if(isEmpty){
      c = 100;
    } else {
      c = 200;
    }
  }

  public void setEmpty(boolean isEmpty) {
    this.isEmpty = isEmpty;
    if(isEmpty){
      c = 100;
    } else {
      c = 200;
    }
  }

  public float[] getCorner(int i) {
    float[] cornerCoords = new float[2];
    switch(i) {
    case 0:
      cornerCoords[0] = x;
      cornerCoords[1] = y;
      break;
    case 1:
      cornerCoords[0] = x+1;
      cornerCoords[1] = y;
      break;
    case 2:
      cornerCoords[0] = x+1;
      cornerCoords[1] = y+1;
      break;
    case 3:
      cornerCoords[0] = x;
      cornerCoords[1] = y+1;
      break;
    }
    return cornerCoords;
  }

  //eventually remove render
  public void render() {
    fill(c);
    noStroke();
    rect((x+0.0)*1, (y+0.0)*1, 1, 1);
  }
}
