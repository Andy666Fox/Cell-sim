abstract class Entity {
  Entity(){};
}

abstract class StaticEntity extends Entity {
  PVector pos;
  int radius;

  StaticEntity(float x, float y, int radius) {
    pos = new PVector(x, y);
    this.radius = radius*2;
  }

  void display() {
    stroke(0);
    fill(255, 255, 255);
    circle(pos.x, pos.y, radius*2);
  }
}

class DynamicEntity extends Entity {
  PVector position;
  int radius;

  PVector velocity;
  float maxSpeed = 5;
  float maxForce = 0.5;

  float vradius = 50;

  DynamicEntity(float x, float y, int r) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    radius = r;
  }

  void display() {
    stroke(0);
    fill(255, 255, 255);
    circle(position.x, position.y, radius*2);
  }

  void borders() {
    position.x = (position.x + width) % width;
    position.y = (position.y + height) % height;
  }
}
