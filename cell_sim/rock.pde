class Rock extends StaticEntity {

  Rock(float x, float y, int radius) {
    super(x, y, radius);
  }

  void display() {
    stroke(0);
    fill(27, 27, 27);
    circle(pos.x, pos.y, radius);
  }
}
