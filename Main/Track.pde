// class that defines where the enemies go next
public class Track {
  private boolean[][] track;

  public Track() {
    track = new boolean[squaresX][squaresY];
    for (int x = 0; x < squaresX; x++) {
      for (int y = 0; y < squaresY; y++) {
        track[x][y] = false;
      }
    }
  }

  public Track(boolean[][] track) {
    this.track = track;
  }

  public boolean[][] getTrack() {
    return track;
  }
}
