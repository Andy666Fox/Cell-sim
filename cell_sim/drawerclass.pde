class Drawer {
  Drawer() {
  };

  void drawEntity(String type) {
    if (type.equals("Rock")) {
      for (Rock r : rocks) r.display();
    }

    if (type.equals("Food")) {
      for (Food f : foods) f.display();
    }

    if (type.equals("ColdZone")) {
      for (ColdZone cz : coldzones) cz.display();
    }

    if (type.equals("Prey")) {
      for (Prey p : preys) p.display();
    }

    if (type.equals("Predator")) {
      for (Predator predator : predators) predator.display();
    }
  }
}
