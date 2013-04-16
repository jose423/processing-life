//Landscapes
Ocean o;
Forest f;

//Waves
Wave w = new Wave();

// users will decide how large the ecosystem is
int numberMoversLarge = 150;
int numberMoversMedium = 100;
int numberMoversSmall = 1; //default

//global universal forces
PVector wind;
int mass;

int seedx = 1;
int seedy = 10;

//movements
Perlin_Movement movementPerlin;
Movement movementLand;

//creature arrays
Creature[] OceanMovers; //holds all different kind of swimmers
Creature[] LandMovers; //holds all different kind of walkers

void setup() {
  size(700, 700);
  smooth();
  f = new Forest(); //construct forest
  o = new Ocean(); //construct ocean
  mass = 10; //starting mass value
  movementPerlin = new Perlin_Movement(random(100), random(200)); //construct default movement, I will make an original movement for each creature
  movementLand = new Movement();
  //it would be cool to have wind move in waves
  wind = new PVector(0.0, 0.2); //default moves objects down screen (y)

  //construct arrays with specific sizes
  LandMovers = new Creature[numberMoversMedium];
  OceanMovers = new Creature[numberMoversMedium];

  //construct initial land movers
  for (int i = 0; i < numberMoversMedium; i++) {
    LandMovers[i] = new Creature(movementLand, f, mass);
    mass = mass + 1;
  }

  //construct initial water movers
  for (int i = 0; i < numberMoversMedium; i++) {
    movementPerlin = new Perlin_Movement(random(seedx), random(seedy)); //assign perlin movement new values each time it enters loop
    switch(int(random(2))) { //randomly decide if popular or regular
    case 0:
      OceanMovers[i] = new PopularCreature(movementPerlin, o, mass); //make a popular creature
      break;
    case 1:
      OceanMovers[i] = new Creature(movementPerlin, o, mass);
      OceanMovers[i].setAttractorForce(o.getAttractor().location); // should this be done in landscape? //unpopular creatures are attracted to the mouse-placed attractor and other popular creatures
      break;
    default:
    }
    seedx += 1;
    seedy += 10;
    mass = mass + 1;
  }
}
void draw() {
  background(232, 198, 167);
  f.display();
  for (int i = 0; i < LandMovers.length;i++) {
    LandMovers[i].applyForce(wind);
    LandMovers[i].update();
    //    LandMovers[i].display(); //being weird
    LandMovers[i].checkEdges(); //this presents problems for the attract methods because it doesn't give enough space for them to steer and return to the attractor
  }
  o.display();
  o.update();
  movementPerlin.update(); //update values in perlin movement
  for (int i = 0; i < OceanMovers.length;i++) {
    //apply attractor forces
    PVector attractForce = o.getCreatureAttractorForce(OceanMovers[i]); //ugly UG:LY landscapes have attractors that can be changed, 
    //this method find out the particular landscape associated with the creature
    OceanMovers[i].applyForce(attractForce);
    //show attractor (for now)
    o.getAttractor().display();
    //apply wind
    OceanMovers[i].applyForce(wind);
    //update location
    OceanMovers[i].update();
    OceanMovers[i].display();
    OceanMovers[i].checkEdges(); //this presents problems for the attract methods because it doesn't give enough space for them to steer and return to the attractor
  }
  w.update();
  w.display();
  w.checkEdges();
}
void mousePressed() {
  o.setAttractor(new Attractor(mouseX, mouseY)); //add new attractor at mouse location, LATER: restrict where it can be placed?
}

