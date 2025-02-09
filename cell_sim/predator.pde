class Predator extends DynamicEntity {
  float maxSpeed = 1.9;
  float maxForce = 0.18;

  float vradius = 70;

  float energy = random(50, 70);
  int toDivide = 0;

  ArrayList<Entity> visibleObjects = new ArrayList<>();

  Predator(float x, float y, int r) {
    super(x, y, r);
  }

  void update() {
    detectObjects();

    PVector seekForce = seek();
    PVector avoidForce = avoid();

    applyForce(seekForce);
    applyForce(avoidForce);
    
    divide();

    position.add(velocity);
    borders();

    energy -= 0.2;
  }

  void detectObjects() {
    visibleObjects.clear();

    for (Prey p : preys) {
      if (PVector.dist(position, p.position) < vradius) {
        visibleObjects.add(p);
      }
    }

    for (Rock r : rocks) {
      if (PVector.dist(position, r.pos) < vradius) {
        visibleObjects.add(r);
      }
    }
  }

  PVector seek() {
    PVector sum = new PVector();
    int count = 0;

    for (Entity e : visibleObjects) {
      if (e instanceof Prey) {
        Prey en = (Prey) e;
        PVector desired = PVector.sub(en.position, position);
        desired.normalize().mult(maxSpeed);
        sum.add(desired);
        sum.add(new PVector(random(-0.5, 0.5), random(-0.5, 0.5)));
        count++;
      }
    }

    if (count > 0) {
      sum.div(count);
      return sum.limit(maxForce);
    }
    return new PVector();
  }

  PVector avoid() {
    PVector sum = new PVector();
    int count = 0;

    for (Entity e : visibleObjects) {
      if (e instanceof Rock) {
        Rock en = (Rock) e;
        PVector desired = PVector.sub(position, en.pos);
        desired.normalize().mult(maxSpeed);
        sum.add(desired);
        sum.add(new PVector(random(-0.5, 0.5), random(-0.5, 0.5)));
        count++;
      }
    }

    if (count > 0) {
      sum.div(count);
      return sum.limit(maxForce * 1.5); // Усиленная сила избегания
    }
    return new PVector();
  }

  void applyForce(PVector force) {
    velocity.add(force);
    velocity.limit(maxSpeed);
  }

  void divide() {
    if (energy >= 250 && ochkoTovarischa()) {
      float nx = position.x + radius + random(5);
      float ny = position.y + radius + random(5);
      float angle = atan(random(TWO_PI));
      predators.add(new Predator(nx+cos(angle), ny+sin(angle), 15));
      energy = energy / 2;
    }
  }

  boolean ochkoTovarischa(){
    for (Predator other: predators){
      if (this == other) continue;
      float dist = position.dist(other.position);
      if (dist < (vradius/3)) return true;
    }
    return false;
  }
  
  void die() {
    PVector dieCoords = position.copy();
    predators.remove(this);
    foods.add(new Food(dieCoords.x, dieCoords.y, int(random(3))));
  }

  void display() {
    // display cell
    stroke(0);
    strokeWeight(3);
    fill(228, 12, 240);
    circle(position.x, position.y, radius);
    strokeWeight(1);
    noStroke();
    noFill();

    // display cell vision radius
    //stroke(10);
    //fill(0, 128, 128, 128);
    //circle(position.x, position.y, vradius);
  }
}
