public class Enemy {
  private PVector pos, dir;
  private int id, markCount = 0;
  private PImage sprite;
  private float vel = 2;

  public Enemy(int id, PVector pos) {
    this.id = id;
    sprite = loadImage("Enemies/" + id + ".png");
    this.pos = pos.copy();
    dir = new PVector();
  }

  public void update() {
    PVector dirTemp = game.level.track.points.get(markCount).copy().sub(pos).copy();
    if (dirTemp.mag() <= vel) {
      markCount++;
    }
    if (game.level.track.points.get(markCount) == null) {
      // do something with life thing idk
    } else {
      dir = game.level.track.points.get(markCount).copy().sub(pos).copy().setMag(vel);
    }
    pos.add(dir);
  }

  public void render() {
    /*
    imageMode(CENTER);
     image(sprite, pos.x, pos.y);*/
    stroke(0);
    strokeWeight(1);
    fill(0, 0, 255);
    rectMode(CENTER);
    rect(pos.x, pos.y, 10, 10);
  }
}
