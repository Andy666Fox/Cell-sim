class PopulationController {
  PopulationController() {
  };

  void controlPopulation() {
    for (Prey prey : preys) {
      if (prey.energy <= 0) {
        prey.die();
      } else {
        prey.update();
      }
    }
    for (Predator predator : predators) {
      if (predator.energy <= 0) {
        predator.die();
      } else {
        predator.update();
      }
    }
  }
}
