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
import processing.opengl.*;


Ocean o;
Land l;
Moon ourMoon;
Sun s;

boolean currentTide;//value representing tide (low or high)
int totalMovers = 20; //total movers for both landscapes

Creature[] allOceanMovers = new Creature[totalMovers];//empty array with size of all ocean movers
Creature[] allGroundMovers = new Creature[totalMovers]; //empty array with size of all ground movers
Creature[] allRandomMovers = new Creature[totalMovers];
Creature[] allMovers = new Creature[allGroundMovers.length + allOceanMovers.length + allRandomMovers.length]; //holds all of movers made

PVector mouse = new PVector(mouseX, mouseY); //vector representing mouse
PVector wind, gravity, resistance; //some forces (add more, like friction)

void setup() {
  size(700, 700, OPENGL); //set size of sketch
  o = new Ocean(width, height); //construct Ocean landscape of type Landscape with given size
  l = new Land(width, 100); //construct a Land of type Landscape with given size
  ourMoon = new Moon(); //construct Moon to determine tide patterns for Ocean objects
  s = new Sun();
  smooth();
  wind = new PVector(0.002, 0.01); //construct uniform wind force
  gravity = new PVector(0, 0.003, -0.01); //construct uniform gravity force
  resistance = new PVector(0.04, 0); //construct uniform resistance force for Creatures


  for (int i = 0; i< allGroundMovers.length; i++) {
    allGroundMovers[i] = new Mover(l, int(random(4, 10)), random(100.0)); //randomize the age between 4 and 10 (which affects mass and size) and randomize spirit value [0,100] **put method that ages
    allMovers[i] = allGroundMovers[i]; //fill allMovers array of Creatures
  }
  int tempTotal = allGroundMovers.length; //starting value for next for loop

  //construct all movers with Landscape Ocean and fill array
  for (int i = 0; i< allOceanMovers.length; i++) {
    allOceanMovers[i] = new Mover(o, int(random(4, 10)), random(100.0)); //randomize the age between 4 and 10 (which affects mass and size) and randomize spirit value [0,100] **put method that ages
    allMovers[tempTotal] = allOceanMovers[i]; //fill allMovers array
    tempTotal++;
  }

  for (int i = 0; i<allRandomMovers.length; i++) {
    allRandomMovers[i] = new Mover(o, int(random(0, 10)), random(70.00, 100.0)); //randomize the age between 4 and 10 (which affects mass and size) and randomize spirit value [0,100] **put method that ages
    allMovers[tempTotal] = allRandomMovers[i]; //fill allMovers array of Creatures
    tempTotal++;
  }
}
void draw() {
  println(allMovers.length);
  background(255, 228, 181);//clear background
  mouse = new PVector(mouseX, mouseY); //vector representing the mouse to be used in seek and flee methods
  l.display(); //show land

  //    allMovers[i].applyForce(gravity); //apply gravity force (Make 3D?), make smaller  

  //GROUND MOVERS
  for (int i = allGroundMovers.length - 1; i >= 0; i--) { //for all movers

    if (allMovers[i].getMoverLandscape() instanceof Land) { //if movers are land call flee, and moves away from mouse
      allMovers[i].update(); //update all movers (eventually show movers only with display of landscape to avoid showing movers on the wrong landscape with overlap
      allMovers[i].display(); //show movers

      allMovers[i].checkEdges(allMovers[i].getMoverLandscape()); //each mover has a landscape involved with it's constructor

      if (allMovers[i].getSpirit() < 20.0) { //if their spirit is less than 50
        allMovers[i].setColor(100, 0, 100); //change their color
        allMovers[i].flee(mouse); //makes the circles smaller and move away from mouse (make more dramatic)
      }
      if (currentTide) {
        if (allMovers[i].getSpirit() > 40.0 && ( allMovers[i].getLocation().x >= l.getCenterX() + l.getHeight())) {
          allMovers[i].setMoverLandscape(o);
        }
        resistance.mult(abs((allMovers[i].getSpirit()/100.0)));
        allMovers[i].applyForce(resistance);
        allMovers[i].setSpirit(abs(allMovers[i].getSpirit() + 0.02));
      } 
      else {
        resistance.div(1.001);
        allMovers[i].applyForce(resistance);
      }
    }
  }
  o.updateTide(ourMoon); //update tide according to moon, changing location vector of ocean landscape
  currentTide = o.checkTide(ourMoon);  //checks tide of particular moon
  o.update(); //updates ocean and draws, increments direction of moon

  for (int i = allGroundMovers.length + allOceanMovers.length; i > 0; i--) { //for all movers
  println(i);
    if (allMovers[i].getMoverLandscape() instanceof Ocean) { //if movers are in ocean

      allMovers[i].applyForce(wind);
      allMovers[i].update(); //show all movers (eventually show movers only with display of landscape to avoid showing movers on the wrong landscape with overlap
      allMovers[i].display();

      allMovers[i].checkEdges(allMovers[i].getMoverLandscape()); //each mover has a landscape involved with it's constructor

      //move fish from negative z to positive gravity?
      if ( allMovers[i].getSpirit() < 50.0) {
        allMovers[i].setColor(100, 35, 100);
        allMovers[i].seek(mouse);
      }
      if (currentTide) {
        //change landscape when tide is high, Mover has landscape water and within (some) distance from border

        //distance between movers location and border of the landscape is
        //subtract location.x of object from centerOcean.x
        if (allMovers[i].getSpirit() < 20.0 && (o.getCenterX() == allMovers[i].getLocation().x)) {
          allMovers[i].setMoverLandscape(l);
          //change spirit level?
        }
        //make Land creature change to Ocean landscape

        resistance.mult(abs((allMovers[i].getSpirit()/100.0)));
        allMovers[i].applyForce(resistance);
        allMovers[i].setSpirit(abs(allMovers[i].getSpirit() - 0.02));
      } 
      else {
        resistance.div(1.001);
        allMovers[i].applyForce(resistance);
      }
    }
  }
}

