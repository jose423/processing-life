// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

/*
instead can the mover accelerate when it hits another mover?
 what is the best way to accomplish this? 
 We don't want every mover to have to know about all other movers
 Maybe let's start where there are new boundaries the mover is limited to,
 for example fish creatures must stay in the water
 add force that makes the mover struggle against the tide? fiesty? 
 */

Ocean o;
Land l;
Moon ourMoon;
Sun s;

boolean currentTide;//value representing tide (low or high)
int totalMovers = 10; //total movers for both landscapes

Creature[] allOceanMovers = new Creature[totalMovers];//empty array with size of all ocean movers
Creature[] allGroundMovers = new Creature[totalMovers]; //empty array with size of all ground movers
Creature[] allMovers = new Creature[allGroundMovers.length + allOceanMovers.length]; //holds all of movers made

PVector mouse = new PVector(mouseX, mouseY); //vector representing mouse
PVector wind, gravity, resistance; //some forces (add more, like friction)

void setup() {
  size(700, 700); //set size of sketch
  o = new Ocean(width, height); //construct Ocean landscape of type Landscape with given size
  l = new Land(130, height); //construct a Land of type Landscape with given size
  ourMoon = new Moon(); //construct Moon to determine tide patterns for Ocean objects
  s = new Sun();
  smooth();
  wind = new PVector(0.002, 0.01); //construct uniform wind force
  gravity = new PVector(0, 0.003); //construct uniform gravity force
  resistance = new PVector(0.04, 0); //construct uniform resistance force for Creatures

  //construct all movers with Landscape Ocean and fill array
  for (int i = 0; i<totalMovers; i++) {
    allOceanMovers[i] = new Mover(o, int(random(4, 10)), random(100.0)); //randomize the age between 4 and 10 (which affects mass and size) and randomize spirit value [0,100] **put method that ages
    allMovers[i] = allOceanMovers[i]; //fill allMovers array
  }
  int tempTotal = allOceanMovers.length; //starting value for next for loop

  for (int i = 0; i<totalMovers; i++) {
    allGroundMovers[i] = new Mover(l, int(random(4, 10)), random(100.0)); //randomize the age between 4 and 10 (which affects mass and size) and randomize spirit value [0,100] **put method that ages

    allMovers[tempTotal] = allGroundMovers[i]; //fill allMovers array of Creatures
    tempTotal++;
  }
  l.display(); //show land
  currentTide = o.checkTide(ourMoon);  //too much in one method? checks tide of particular moon
  o.update();
  o.display();
  s.update();
}

void draw() {
  background(255, 228, 181);//clear background
  mouse = new PVector(mouseX, mouseY); //vector representing the mouse
  l.display(); //show land

  o.updateTide(ourMoon);
  currentTide = o.checkTide(ourMoon);  //too much in one method? checks tide of particular moon
  o.update();
  o.display();
  
  for (int i = allMovers.length - 1; i >= 0; i--) {

    allMovers[i].applyForce(gravity);

    if (allMovers[i].getMoverLandscape() instanceof Land) {
      allMovers[i].flee(mouse);
    }
    if (allMovers[i].getMoverLandscape() instanceof Ocean) {
      allMovers[i].applyForce(wind);

      if ( allMovers[i].getSpirit() < 50.0) {
        allMovers[i].setColor(100, 35, 100);
        allMovers[i].seek(mouse);
      }
      if (currentTide) {
        //change landscape when tide is high, Mover has landscape water and within (some) distance from border

        //distance between movers location and border of the landscape is
        //subtract location.x of object from centerOcean.x

        //        if (allMovers[i].getSpirit() < 20.0 && (o.getCenterX() == allMovers[i].location.x)) {
        //          allMovers[i].setMoverLandscape(l);
        //        }
        //make Land creature change to Ocean landscape
        //        if (allMovers[i].getSpirit() < 10.0 && (allMovers[i].location.x == o.centerOcean.x)) {
        //          allMovers[i].setMoverLandscape(o);
        //        }

        resistance.mult(abs((allMovers[i].getSpirit()/100.0)));
        allMovers[i].applyForce(resistance);
        allMovers[i].setSpirit(abs(allMovers[i].getSpirit() - 0.02));
      }
      else {
        resistance.div(1.001);
        allMovers[i].applyForce(resistance);
      }
    }
    allMovers[i].update(); //show all movers (eventually show movers only with display of landscape to avoid showing movers on the wrong landscape with overlap
    allMovers[i].display();

    allMovers[i].checkEdges(allMovers[i].getMoverLandscape()); //each mover has a landscape involved with it's constructor
  }
    s.update();

}
void mousePressed() {
  //  if (mouseX >= o.getCenterY() && mouseX < o.getWidth() + o.getCenterY()) {
  //    for (int i=0;i < allOceanMovers.length;i++) {  
  //      allOceanMovers[i].agitate();
  //    }
  //  }
  //  if (mouseY >= o.getCenterX() && mouseY < o.getHeight() + o.getCenterX()) {
  //    for (int i=0;i < allOceanMovers.length;i++) {  
  //      allOceanMovers[i].agitate();
  //    }
  //  }
}

