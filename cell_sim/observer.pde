class Observer{
  Observer(){};
  
  void info(){
    fill(227, 29, 11);
    textSize(24);
    textAlign(LEFT, TOP);
    fill(227, 29, 11);
    text("Predators count: " + predators.size(), 10, 10);
    fill(11, 227, 189);
    text("Preys count: " + preys.size(), 10, 30);
    fill(16, 227, 17);
    text("Food count: " + foods.size(), 10, 50);
  }
}
