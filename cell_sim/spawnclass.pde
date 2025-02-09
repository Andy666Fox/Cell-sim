class Spawner {
  Spawner() {
  };

  void spawnEntity(String type, int count, int minc, int maxc) {
    if (type.equals("Rock")) {
      for (int i = 0; i < count; i++) {
        rocks.add(new Rock(random(width), random(height), int(random(minc, maxc))));
      }
    }

    if (type.equals("Food")) {
      for (int i = 0; i < count; i++) {
        foods.add(new Food(random(width), random(height), int(random(minc, maxc))));
      }
    }

    if (type.equals("ColdZone")) {
      for (int i = 0; i < count; i++) {
        coldzones.add(new ColdZone(random(width), random(height), int(random(minc, maxc))));
      }
    }

    if (type.equals("Prey")) {
      for (int i = 0; i < count; i++) {
        preys.add(new Prey(random(width), random(height), minc));
      }
    }

    if (type.equals("Predator")) {
      
      for (int i = 0; i < count; i++) {
        predators.add(new Predator(random(width), random(height), minc));
      }
    }
  }
}
