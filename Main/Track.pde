// class that defines where the enemies go next
public class Track {
  private int[][] track;

  public Track() {
    track = new int[squaresX][squaresY];
    for (int x = 0; x < squaresX; x++) {
      for (int y = 0; y < squaresY; y++) {
        track[x][y] = 0;
      }
    }
  }

  public Track(int[][] track) {
    this.track = track;
  }

  public int[][] getTrack() {
    return track;
  }
}
