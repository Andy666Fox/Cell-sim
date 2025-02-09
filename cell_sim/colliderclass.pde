class Collider {
  int foodsEnergy = 50;
  Collider() {
  };

  void rockRockCollideControl() {
    for (int i = 0; i < rocks.size(); i++) {
      Rock r1 = rocks.get(i);
      for (int j = 1; j < rocks.size()-1; j++) {
        Rock r2 = rocks.get(j);

        float dx = r1.pos.x - r2.pos.x;
        float dy = r1.pos.y - r2.pos.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = r1.radius + r2.radius;

        if (distance < minDist) {
          float angle = atan2(dy, dx);
          r2.pos.x += cos(angle) * minDist;
          r2.pos.y += sin(angle) * minDist;

          r1.pos.x -= cos(angle) * minDist;
          r1.pos.y -= sin(angle) * minDist;
        }
      }
    }
  }

  void foodFoodCollideControl() {
    for (int i = 0; i < foods.size(); i++) {
      Food f1 = foods.get(i);
      for (int j = 1; j < foods.size()-1; j++) {
        Food f2 = foods.get(j);

        float dx = f1.pos.x - f2.pos.x;
        float dy = f1.pos.y - f2.pos.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = f1.radius + f2.radius;

        //println(f1.radius, f1.pos, distance);

        if (distance < minDist) {
          float angle = atan2(dy, dx);
          f2.pos.x += cos(angle) * minDist;
          f2.pos.y += sin(angle) * minDist;

          f1.pos.x -= cos(angle) * minDist;
          f1.pos.y -= sin(angle) * minDist;
        }
      }
    }
  }

  void foodRockCollideControl() {
    for (int i = 0; i < foods.size(); i++) {
      Food f = foods.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock r = rocks.get(j);

        float dx = f.pos.x - r.pos.x;
        float dy = f.pos.y - r.pos.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = f.radius + r.radius;

        //println(f1.radius, f1.pos, distance);

        if (distance < minDist) {
          float angle = atan2(dy, dx);
          f.pos.x += cos(angle) * minDist;
          f.pos.y += sin(angle) * minDist;

          //f1.pos.x -= cos(angle) * minDist;
          //f1.pos.y -= sin(angle) * minDist;
        }
      }
    }
  }

  void czCzCollideControl() {
    for (int i = 0; i < coldzones.size(); i++) {
      ColdZone cz1 = coldzones.get(i);
      for (int j = 1; j < coldzones.size()-1; j++) {
        ColdZone cz2 = coldzones.get(j);

        float dx = cz1.pos.x - cz2.pos.x;
        float dy = cz1.pos.y - cz2.pos.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = cz1.radius + cz2.radius;

        if (distance < minDist) {
          float angle = atan2(dy, dx);
          cz1.pos.x += cos(angle) * minDist;
          cz1.pos.y += sin(angle) * minDist;

          cz2.pos.x -= cos(angle) * minDist;
          cz2.pos.y -= sin(angle) * minDist;
        }
      }
    }
  }

  void preyPredatorCollideControl() {
    for (int i = 0; i < predators.size(); i++) {
      Predator predator = predators.get(i);
      for (int j = 0; j < preys.size(); j++) {
        Prey prey = preys.get(j);

        float dx = predator.position.x - prey.position.x;
        float dy = predator.position.y - prey.position.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = predator.radius + prey.radius - 5;

        if (distance < minDist) {
          predator.energy += prey.energy / 2;
          preys.remove(j);
        }
      }
    }
  }

  void preyFoodCollideControl() {
    for (int i = 0; i < preys.size(); i++) {
      Prey prey = preys.get(i);
      for (int j = 0; j < foods.size(); j++) {
        Food food = foods.get(j);

        float dx = prey.position.x - food.pos.x;
        float dy = prey.position.y - food.pos.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = prey.radius + food.radius;

        if (distance < minDist && prey.energy < 100) {
          if (food.type == 0) prey.energy += foodsEnergy;
          if (food.type == 1) prey.velocity.add(1, 1);
          if (food.type == 2) prey.toDivide ++;
          foods.remove(j);
        }
      }
    }
  }


  void cellColdZoneCollideControl() {
    for (Predator predator : predators) {
      for (ColdZone cz : coldzones) {

        float dx = predator.position.x - cz.pos.x;
        float dy = predator.position.y - cz.pos.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = predator.radius + cz.radius;

        if (distance < minDist && predator.energy < 55) {
          predator.energy -= 0.5;
          predator.maxSpeed = 0.95;
        } else {
          predator.maxSpeed = 1.9;
        }
      }
    }

    for (Prey prey : preys) {
      for (ColdZone cz : coldzones) {

        float dx = prey.position.x - cz.pos.x;
        float dy = prey.position.y - cz.pos.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = prey.radius + cz.radius;

        if (distance < minDist) {
          prey.energy -= 0.4;
          prey.maxSpeed = 0.75;
        } else {
          prey.maxSpeed = 1.5;
        }
      }
    }
  }
}
