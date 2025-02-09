class Food extends StaticEntity {
  // type 0 for yellow food (increase cell energy)
  // type 1 for orange food (temporary increase cells speed)
  // type 2 for white food (if eaten enough cell can divide to two new cells)
  int type;
  Food(float x, float y, int type) {
    super(x, y, type);
    this.type = type;
    this.radius = 10;
  }

  void display() {
    stroke(0);
    strokeWeight(1.5);
    if (type == 0) {
      fill(255, 255, 0);
      circle(pos.x, pos.y, radius);
    }

    if (type == 1) {
      fill(255, 95, 21);
      circle(pos.x, pos.y, radius);
    }

    if (type == 2) {
      fill(200);
      circle(pos.x, pos.y, radius);
    }
    strokeWeight(1);
  }
}
