class Prey extends DynamicEntity {
  float maxSpeed = 1.7;
  float maxForce = 0.15;

  float vradius = 60;
  
  float energy = random(50, 120);
  int toDivide = 0;

  ArrayList<Entity> visibleObjects = new ArrayList<>();

  Prey(float x, float y, int r) {
    super(x, y, r);
  }

  void update() {
    
    if (energy <= 0) preys.remove(this);
    detectObjects();

    PVector seekForce = seek();
    PVector avoidForce = avoid();

    applyForce(seekForce);
    applyForce(avoidForce);
    
    divide();

    position.add(velocity);
    borders();
    
    energy -= 0.1;
  }

  void detectObjects() {
    visibleObjects.clear();

    for (Food f : foods) {
      if (PVector.dist(position, f.pos) < vradius) {
        visibleObjects.add(f);
      }
    }

    for (Rock r : rocks) {
      if (PVector.dist(position, r.pos) < vradius) {
        visibleObjects.add(r);
      }
    }

    for (Predator p: predators){
      if (PVector.dist(position, p.position) < vradius){
        visibleObjects.add(p);
      }
    }
  }
  
  PVector seek(){
    PVector sum = new PVector();
    int count = 0;
    
    for (Entity e: visibleObjects){
      if (e instanceof Food){
        Food en = (Food) e;
        PVector desired = PVector.sub(en.pos, position);
        desired.normalize().mult(maxSpeed);
        sum.add(desired);
        sum.add(new PVector(random(-0.5, 0.5), random(-0.5, 0.5)));
        count++;
      }
    }
    
    if (count > 0){
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
    
    for (Entity e : visibleObjects) {
      if (e instanceof Predator) {
        Predator en = (Predator) e;
        PVector desired = PVector.sub(position, en.position);
        desired.normalize().mult(maxSpeed);
        sum.add(desired);
        count++;
      }
    }
    
    if (count > 0) {
      sum.div(count);
      return sum.limit(maxForce * 1.5); // Усиленная сила избегания
    }
    return new PVector();
  }
  
  void applyForce(PVector force){
    velocity.add(force);
    velocity.limit(maxSpeed);
  }
  
  void divide(){
    if (toDivide >= 5){
      float nx = position.x + radius + random(5);
      float ny = position.y + radius + random(5);
      float angle = atan(random(TWO_PI));
      preys.add(new Prey(nx+cos(angle), ny+sin(angle), 10));
      toDivide -= 5;
      energy = energy / 2;
    } 
  }
  
  void die(){
    PVector dieCoords = position.copy();
    preys.remove(this);
    foods.add(new Food(dieCoords.x, dieCoords.y, 2));
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(12, 240, 173);
    circle(position.x, position.y, radius);
    strokeWeight(1);
    noStroke();
    noFill();
    
    //stroke(10);
    //fill(0, 128, 0, 128);
    //circle(position.x, position.y, vradius);
  }
}
