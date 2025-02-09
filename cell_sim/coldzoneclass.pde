class ColdZone extends StaticEntity {

  ColdZone(float x, float y, int radius) {
    super (x, y, radius);
  }

  void display() {
    stroke(20);
    fill(135, 206, 255, 90);
    circle(pos.x, pos.y, radius);
  }
}
