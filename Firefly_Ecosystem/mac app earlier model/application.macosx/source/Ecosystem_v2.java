import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Ecosystem_v2 extends PApplet {

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

public void setup() {
  size(700, 700);
  smooth();
  f = new Forest(); //construct forest
  o = new Ocean(); //construct ocean
  mass = 10; //starting mass value
  movementPerlin = new Perlin_Movement(random(100), random(200)); //construct default movement, I will make an original movement for each creature
  movementLand = new Movement();
  //it would be cool to have wind move in waves
  wind = new PVector(0.0f, 0.2f); //default moves objects down screen (y)

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
    switch(PApplet.parseInt(random(2))) { //randomly decide if popular or regular
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
public void draw() {
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
public void mousePressed() {
  o.setAttractor(new Attractor(mouseX, mouseY)); //add new attractor at mouse location, LATER: restrict where it can be placed?
}

/**
 This class will have a visual element and is intended for creation of attractor objects placed by the user,
 the Popular Creature class has the attract method to attract other creatures
 
 **/
class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  PVector dragOffset;  // holds the offset for when object is clicked on

  Attractor(float _x, float _y) {
    location = new PVector(_x, _y);
    mass = 1;
    G = 1;
    dragOffset = new PVector(0.0f, 0.0f);
  }
  public void display() {
    fill(255);
    ellipse(location.x,location.y,20,20);
  }
  public PVector attract(Creature m) {
    PVector force = PVector.sub(location, m.location);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 0.0f, 10.0f);    // Limiting the distance to eliminate "extreme" results for very close or very far objects

    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
    force.mult(strength);                                  // Get force vector --> magnitude * direction

    return force;
  }
}

class Creature {
  Movement m; //movement associated with creature
  Landscape l; //landscape associated with creature
  PVector location, velocity, acceleration, resistance, attracted;
  int maxSpeed, maxForce; //set max speed for velocity
  float mass; //mass affects the impact of the force

  Creature(Movement defaultM, Landscape defaultL, int _mass) {
    m = defaultM; //set initial movement
    l = defaultL; //set initial landscape
    maxSpeed = 1; //set max speed
    maxForce = 2;
    mass = _mass; //set mass
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps)
    resistance = new PVector(0, 0);
    attracted = l.getAttractor().location; //set attractor to landscape-default
  }

  public void update() {
    attracted = l.getAttractor().location; //get the current location of the attractor for landscape
    PVector desired = PVector.sub(attracted, location); //target is the attracted creatures or inanimate attracted objects location
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
    applyForce(m.applyMovement()); //apply movement associated with current creature
    applyForce(resistance); //all creatures apply resistance, change somewhere else
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }

  public void display() {
    fill(200, 20, 20, 90);
    noStroke();
    ellipse(location.x, location.y, random(5, 10), 10);
  }

  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impact (1/100) vs. (1/1000)
    acceleration.add(force);
  }

  //assign Creature with particular movement (i.e. Perlin, Random)
  public void setMovement(Movement _m) {
    m = _m;
  }
  // returns the current movement applied to the Creature
  public Movement getMovement() {
    return m;
  }
  //assign Creature with particular Landcape (movement bounds)
  public void setLandscape(Landscape _l) {
    l = _l;
  }
  // returns the current landscape (movement bounds) applied to the Creature
  public Landscape getLandscape() {
    return l;
  }
  public PVector getAttractorForce() { //return attracted force as PVector
    return attracted;
  }
  public void setAttractorForce(PVector _attracted) { //set attractor force for landscape's attractor
    attracted = _attracted;
  }
  public void checkEdges() {

    if (location.x > l.lWidth) {
      location.x = l.lWidth + l.lCorner.x;
      velocity.x *= -1;
    } 
    else if (location.x < l.lCorner.x) {
      location.x = l.lCorner.x;
      velocity.x *= -1;
    }

    if (location.y > l.lHeight) {
      location.y = l.lHeight + l.lCorner.y;
      velocity.y *= -1;
    }
    else if (location.y < l.lCorner.y) {
      location.y = l.lCorner.y;
      velocity.y *= -1;
    }
  }
}

class Forest extends Landscape {

  Forest() {
    lHeight = 200; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 600); //default
  }

  public void display() {
    noStroke();
    fill(0, 170, 100); //green color
    ellipse(lCorner.x, lCorner.y, lWidth, lHeight);
  }
  public float getHeight() {
    return lHeight;
  }
  public float getWidth() {
    return lWidth;
  }
  public void setAttractor(Attractor _a) {
    a = _a;
  }
  public Attractor getAttractor() {
    return a;
  }
  public PVector getCreatureAttractorForce(Creature _c) {
    return a.attract(_c);
  }
}

class Landscape {
  float lHeight;
  float lWidth; 
  PVector lCenter, lCorner;
  Attractor a;

  Landscape() {
    lHeight = height; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 0); //default
    a = new Attractor(lWidth/2, lHeight/2);
  }
  public void update(){
    
  }
  public void display() {
    a.display();
    
    fill(100);
    noStroke();
    rect(lCorner.x, lCorner.y, lWidth, lHeight);
  }
  public float getHeight() {
    return lHeight;
  }
  public float getWidth() {
    return lWidth;
  }
  public void setAttractor(Attractor _a) {
    a = _a;
  }
  public Attractor getAttractor() {
    return a;
  }
  public PVector getCreatureAttractorForce(Creature _c) {
    return a.attract(_c);
  }
}

//class defines a certian type of movement that can be applied to any object with location

/**
 If the movement is random the class will create a random seed and will have methods to determine what acceleration and velocity should be for the object it is applied to
 
 **/
class Movement {

  Movement() {
  }
  public void update() {
  }

  public PVector applyMovement() { // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
    //should I map the value to the confines of the landscape it is in
    return new PVector(random(1),random(1));  //return pvector with added value, in this case it is random
  }
}

class Ocean extends Landscape {
  float angle = 0.1f;
  Ocean() {
    lHeight = 500; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 0); //default
  }
  public void update() {
    angle = angle + 0.02f; //update angle to cause wave motion
  }
  public void display() {
    noStroke();
    fill(0, 190, 200, 100);
    rect(lCorner.x, lCorner.y + sin(angle)*40, lWidth, lHeight);
    fill(0, 200, 255, 90);
    rect(lCorner.x, lCorner.y + sin(angle)*30, lWidth, lHeight);
    fill(0, 190, 240, 80);
    rect(lCorner.x, lCorner.y + sin(angle)*20, lWidth, lHeight);
    fill(0, 10, 255, 70);
    rect(lCorner.x, lCorner.y + sin(angle)*10, lWidth, lHeight);
    fill(0, 10, 255, 60);
    rect(lCorner.x, lCorner.y, lWidth, lHeight);
  }
}

class Perlin_Movement extends Movement {

  float x, y, seedx, seedy;
  PVector force;
  Perlin_Movement(float _seedx, float _seedy) {
    seedx = _seedx;
    seedy = _seedy;
  }
  public void update() {
    float accelerationNoiseX = noise(seedx);
    float accelerationNoiseY = noise(seedy);
    x = map(accelerationNoiseX, 0, 1, 10, -10);
    y = map(accelerationNoiseY, 0, 1, -10, 10);
    seedx =  seedx + 0.1f;
    seedy = seedy + 3;
  }

  public PVector applyMovement() { // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
    //should I map the value to the confines of the landscape it is in
    force = new PVector(x, y);
    return force;  //return pvector with added value, in this case it is random
  }
  public float getX() {
    return force.x;
  }
  public float getY() {
    return force.y;
  }
}

/**
 This class creates a creature that is very popular, meaning it attracts
 other creatures toward it, the attraction will be a seperate class but the
 style and some other tendencies will be in this class
 
 Give it a ocilating heartbeat glowy feeling
 
 **/
class PopularCreature extends Creature {
  float opacity;
  float G;       // Gravitational Constant
  PVector location;   // Location
  PVector dragOffset;  // holds the offset for when object is clicked on
  Perlin_Movement m;
  PVector wind;
  PopularCreature(Perlin_Movement defaultM, Landscape defaultL, int _mass) {
    super(defaultM, defaultL, _mass);
    m = defaultM;
    location = new PVector(random(l.getWidth())/2, random(l.getHeight())/2); //choose random location within bounds of_l
    opacity = 1;
    resistance = new PVector(0.0f, 0.0f);
    mass = 1;
    G = 10;
    dragOffset = new PVector(0.3f, 0.1f);
    wind = new PVector(0,0);
  }
  public void update() {
    if (opacity > 90) {
      opacity = 10;
    }
    else {
      opacity++;
    }
    //update movement before applying
    m.update();
    applyForce(wind);
    applyForce(m.applyMovement()); //apply movement associated with current creature
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }
  public void display() {
    stroke(255);
    strokeWeight(1);
    fill(0, opacity);
    rect(location.x, location.y, 10, 10);
  }
  public void checkEdges() {

    if (location.x > l.lWidth) {
      location.x = l.lWidth + l.lCorner.x;
      velocity.x *= -1;
    } 
    else if (location.x < l.lCorner.x) {
      location.x = l.lCorner.x;
      velocity.x *= -1;
    }

    if (location.y > l.lHeight) {
      location.y = l.lHeight + l.lCorner.y;
      velocity.y *= -1;
    }
    else if (location.y < l.lCorner.y) {
      location.y = l.lCorner.y;
      velocity.y *= -1;
    }
  }
}

class Wave {
  float startAngle;
  float angleVel;
  ArrayList<PVector> erasure = new ArrayList<PVector>();
  int opacity;
  PVector location, acceleration, velocity, run;
  float y;
  int maxSpeed = 3;
  Wave() {
    location = new PVector(0.01f, height/2);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    startAngle = 0.80f;
    angleVel = 0.20f;
    opacity = 100;
    run = new PVector(0.01f, 0);
  }
  public void applyForce(PVector force) {
    acceleration.add(force);
  }

  public void update() {
    run.normalize();
    run.mult(1.1f);
    applyForce(run);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }
  public void display() {
    for (PVector p: erasure) { //erase area where wave moves
      fill(255,10);
      rect(p.x, p.y, 10, 2);
    }

    startAngle += 0.015f;
    float angle = startAngle;

    for (float x = location.x; x <= width; x += 2) {
      println(location.x);
      float y = map(sin(angle), -1, 1, location.x/2, location.y/4);
      stroke(0);
      fill(255, 50);
      strokeWeight(1);
      ellipse(x, y, 10, 10);
      fill(255, 80);
      ellipse(x, y, 2, 2);
      angle += angleVel;
      erasure.add(new PVector(location.x, y));
    }
  }
  public void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Ecosystem_v2" });
  }
}
