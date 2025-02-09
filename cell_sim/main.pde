import java.util.concurrent.CopyOnWriteArrayList;

// static objects lists
CopyOnWriteArrayList<Food> foods = new CopyOnWriteArrayList<>();
CopyOnWriteArrayList<Rock> rocks = new CopyOnWriteArrayList<>();
CopyOnWriteArrayList<ColdZone> coldzones = new CopyOnWriteArrayList<>();

// dynamic objects lists
CopyOnWriteArrayList<Prey> preys = new CopyOnWriteArrayList<>();
CopyOnWriteArrayList<Predator> predators = new CopyOnWriteArrayList<>();

// class who cares about objects collisions and logic behind
Collider cldr = new Collider();
// class displays global simulation info
Observer obs = new Observer();
// class who spawns entities
Spawner spw = new Spawner();
// class who update cells positions, speeds, etc
Updater upr = new Updater();
// class who displayes cells
Drawer drw = new Drawer();
// class who kills cells with expired energy
PopulationController ppctr = new PopulationController();


// initial static objects parameters
int start_food = 1500;
int start_rocks = 25;
int start_coldzones = 5;

// initial dynamic objects parameters
int start_preys = 1200;
int start_predators = 10;

// global params
//int worldSize = 1000;

void setup() {
  size(1000, 1000);
  fullScreen();
  frameRate(60);

  spw.spawnEntity("Rock", start_rocks, 30, 50);
  spw.spawnEntity("Food", start_food, 0, 3);
  spw.spawnEntity("ColdZone", start_coldzones, 50, 100);

  spw.spawnEntity("Prey", start_preys, 10, 10);
  spw.spawnEntity("Predator", start_predators, 15, 15);

  //println(rocks);
}

void draw() {
  background(50);

  upr.updateColdZones();
  upr.updateFood();
  upr.updatePopulation();
  
  ppctr.controlPopulation();

  cldr.foodRockCollideControl();
  cldr.rockRockCollideControl();
  cldr.foodFoodCollideControl();
  cldr.czCzCollideControl();

  cldr.preyPredatorCollideControl();
  cldr.preyFoodCollideControl();
  
  cldr.cellColdZoneCollideControl();


  drw.drawEntity("Food");
  drw.drawEntity("Rock");
  drw.drawEntity("ColdZone");

  drw.drawEntity("Prey");
  drw.drawEntity("Predator");

  obs.info();
}
