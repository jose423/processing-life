/**
 Class that organizes groups of Creatures, giving functionality to clear entire systems, run them and remove friction from all Creatures
 
 **/
class CreatureSystem {
  ArrayList<Creature> system;
  FrictionStructure f;
  CreatureSystem(FrictionStructure _f) {
    system = new ArrayList<Creature>();
    f = _f;
  }
  //adds creature to creature system arraylist
  void addCreature(Movement _m, Landscape _l) {
    system.add(new Creature(_m, _l));
  }
  //clears friction values for all creatures so they can fly freely
  void clearFriction() {
    Iterator<Creature> it = system.iterator();
    while (it.hasNext ()) {
      Creature c = it.next();
      c.clearFriction();
    }
  }
  //runs through all creatures and updates their locations and removes them if necessary
  void run() {
    Iterator<Creature> it = system.iterator();
    while (it.hasNext ()) {
      Creature c = it.next();
      f.contains(c);
      c.update();
      c.display();
      if (c.isDead()) {
        it.remove();
      }
    }
  }
  //method applies wind from direction specified by user
  void addWind(String s) {
    PVector wind;
    Iterator<Creature> it = system.iterator();

    //add wind to the right for all Creatures
    if (s.equals("R")) {
      while (it.hasNext ()) {
        Creature c = it.next();
        wind = new PVector(2, 0);
        c.applyForce(wind);
      }
    }
    //add wind to the left for all Creatures
    if (s.equals("L")) {
      while (it.hasNext ()) {
        Creature c = it.next();
        wind = new PVector(-2, 0);
        c.applyForce(wind);
      }
    }
  }
  //clears all Creatures from the ArrayList
  void clearSystem() {
    system.clear();
  }
}

