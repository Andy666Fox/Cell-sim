class Updater {
  Updater() {
  };

  void updateColdZones() {
    if (frameCount % 300 == 0) {
      coldzones.add(new ColdZone(random(width), random(height), int(random(50, 100))));
    }
    if (coldzones.size() > 5) {
      coldzones.remove(0);
    }
  }

  // control food livetime, count and position
  void updateFood() {
    if (frameCount % 10 == 0) {
      foods.add(new Food(random(width), random(height), int(random(3))));
    }
    if (frameCount % 300 == 0 && foods.size() > 0 && random(100) > 70) {
      foods.remove(0);
    }
  }
  
  void updatePopulation(){
    if (int(random(1000)) < 20) preys.add(new Prey(random(width), random(height), 10));
    if (int(random(1000)) < 10) predators.add(new Predator(random(width), random(height), 15));
  }
}
