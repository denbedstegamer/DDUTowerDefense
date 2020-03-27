// class that defines where the enemies go next
public class Track {
  private ArrayList<PVector> points;

  public Track() {
    points = new ArrayList<PVector>();
  }

  public ArrayList<PVector> getPoints() {
    return points;
  }
}
