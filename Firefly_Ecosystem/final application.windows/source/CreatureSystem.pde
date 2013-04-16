/**
 Class that organizes groups of Creatures, giving functionality to clear entire systems, run them and remove friction from all Creatures
 
 **/
class CreatureSystem {
  ArrayList<Creature> system; //holds Creature
  FrictionStructure f; //FrictionStructure assosiated with creature system
  int seedx = 1; //seed for perlin
  int seedy = 10; //seed for perlin

  CreatureSystem(FrictionStructure _f) {
    system = new ArrayList<Creature>();
    f = _f;
  }
  //adds creature to creature system arraylist with perlin movement seed values
  void addCreature(Landscape _l) {
    system.add(new Creature(_l, seedx, seedy));
    seedx += 1;
    seedy += 10;
  }
  //adds ocillating creature to system arraylist
  void addOscillator(Landscape _l, float x, float y) {
    system.add(new Oscillator(_l, seedx, seedy, x, y));
    seedx += 1;
    seedy += 10;
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
        wind = new PVector(5, 0);
        c.setWindForce(wind);
      }
    }
    //add wind to the left for all Creatures
    if (s.equals("L")) {
      while (it.hasNext ()) {
        Creature c = it.next();
        wind = new PVector(-5, 0);
        c.setWindForce(wind);
      }
    }
    if (s.equals("Stop")) {
      while (it.hasNext ()) {
        Creature c = it.next();
        wind = new PVector(0, 0);
        c.setWindForce(wind);
      }
    }
  }
  //iterates through system to check is creature is found in light location
  void hitLight(Light l) {
    Iterator<Creature> it = system.iterator();
    while (it.hasNext ()) {
      Creature c = it.next();
      //if Creature has hit Lantern, remove from the array
      if (c.location.x > l.location.x && c.location.x < l.location.x + l.w && c.location.y > l.location.y && c.location.y < l.location.y + l.h) {
        //delete from arraylist
        it.remove();
      }
    }
  }
  //clears all Creatures from the ArrayList
  void clearSystem() {
    system.clear();
  }
}

