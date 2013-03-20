//Landscapes
Ocean o;
Forest f;

// users will decide how large the ecosystem is
int numberMoversLarge = 100;
int numberMoversMedium = 50;
int numberMoversSmall = 10; //default

//global universal forces
PVector wind;
int mass;

//first movement
Movement movementDefault;

Creature[] OceanMovers; //holds all different kind of swimmers
Creature[] LandMovers; //holds all different kind of walkers

void setup() {
  size(700, 700);
  smooth();
  f = new Forest(); //construct forest
  o = new Ocean(); //construct ocean
  mass = 10; //starting mass value
  movementDefault = new Movement(); //construct default movement

    //it would be cool to have wind move in waves
  wind = new PVector(0.002, 0.1); //default moves objects down screen (y)

  //construct arrays with specific sizes
  LandMovers = new Creature[numberMoversMedium];
  OceanMovers = new Creature[numberMoversMedium];

  //construct initial land movers
  for (int i = 0; i < numberMoversMedium; i++) {
    LandMovers[i] = new Creature(movementDefault, f, mass);
    mass = mass + 1;
  }
  //construct initial water movers
  for (int i = 0; i < numberMoversMedium; i++) {

    if (i%4==0) { //if i is divisble by 4 make the creature a popular creature
      OceanMovers[i] = new PopularCreature(movementDefault, o, mass);
    }
    else { //else make it a regular (follower) creature
      OceanMovers[i] = new Creature(movementDefault, o, mass);
    }
    mass = mass + 1;
  }
}
void draw() {
  background(232, 198, 167);
  f.display();
  for (int i = 0; i < LandMovers.length;i++) {
    LandMovers[i].update();
    LandMovers[i].display();
    LandMovers[i].checkEdges();
  }
  o.display();
  o.update();
  for (int i = 0; i < OceanMovers.length;i++) {
    OceanMovers[i].update();
    OceanMovers[i].display();
    OceanMovers[i].checkEdges();
  }

  movementDefault.update(); //update values in random movement
}

