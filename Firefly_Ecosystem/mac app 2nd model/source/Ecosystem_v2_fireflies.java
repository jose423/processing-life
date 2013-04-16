import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 
import ddf.minim.signals.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*; 

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

public class Ecosystem_v2_fireflies extends PApplet {






//Landscape
Ocean o;

//Contains multiple friction spaces (make more flexible in formation
FrictionStructure structure = new FrictionStructure();
float c;

// users will decide how large the ecosystem is
int numberMovers = 2 ; //default

//seeds for perlin movement
int seedx = 1;
int seedy = 10;

//holds all creatures who have explored no areas and have below 300 spirit
ArrayList<Creature>withoutSpirit = new ArrayList<Creature>();

//movements
Perlin_Movement movementPerlin;

//system that controls/organizes all creatures
CreatureSystem system;

//holds audio sample
ArrayList<AudioSample>sampleList = new ArrayList<AudioSample>();
Minim minim;
File path;
String[] sounds;
AudioSample wind, bootup;


//color of the background
float ground;


public void setup() {
  size(700, 700);
  smooth();
  //set background color
  ground = 0;

  //sound setup
  minim = new Minim(this);
  path = new File("/Users/mayarichman/Documents/cart 353/Ecosystem_v2_fireflies/bit_coin_sounds");
  sounds = path.list();
  println(sounds);
  //fill array with sounds
  for (int j = 0; j < sounds.length;j++) {
    String song2 = "/bit_coin_sounds/" + sounds[j]; 
    AudioSample test = minim.loadSample(song2, 2048);   
    sampleList.add(test);
  }
  wind = minim.loadSample("winds.aif", 2048);
  bootup = minim.loadSample("bootup-ecosystem.aif", 2048);
  bootup.trigger();
  //build landscape structure
  structure.makeStructure();

  //construct ocean
  o = new Ocean(); 

  //construct movement for creature
  movementPerlin = new Perlin_Movement(random(100), random(200)); //construct default movement, I will make an original movement for each creature

  //initialize CreatureSystem
  system = new CreatureSystem(structure);

  //construct initial creatures and fill arraylist
  for (int i = 0; i < numberMovers; i++) {
    //assign perlin movement new values each time it enters loop
    movementPerlin = new Perlin_Movement(random(seedx), random(seedy)); 

    system.addCreature(movementPerlin, o);
    seedx += 1;
    seedy += 10;
  }
}
public void draw() {
  background(ground);
  
  //update and display friction structure of friction spaces
  structure.update();
  structure.display();
  //display landscape and attractor
  o.display();

  //run creature system
  system.run();

  //update values in perlin movement
  movementPerlin.update();
}
public void mousePressed() {
  o.setAttractor(new Attractor(mouseX, mouseY)); //add new attractor at mouse location, LATER: restrict where it can be placed?
}


public void keyPressed() {
  //clear screen of landscapes and creatures and makes new landscapes
  if (key == CODED) {
    if (keyCode == LEFT) {
      wind.trigger();
      system.addWind("L");
    } 
    if (keyCode == RIGHT) {
      wind.trigger();
      system.addWind("R");
    }
  }
  if (key == 'c') {
    ground = 0;
    //remove movers
    system.clearSystem();
    //clear current landscape display
    structure.clearStructure();
    //build new landscape display, IDEA: variables keep adding or subtracting for location so "scene" changes
    structure.makeStructure();
    bootup.trigger();
  }
  //clears landscapes but leaves creatures without friction
  if (key == 'd') {
    //clear current landscape display
    structure.clearStructure();
    //clear friction so creatures move free
    system.clearFriction();
  }
  //add more creatures doesn't change or remove the landscape
  if (key == 'n') {
    for (int i = 0; i < numberMovers; i++) {
      //assign perlin movement new values each time it enters loop
      movementPerlin = new Perlin_Movement(random(seedx), random(seedy)); 
      //adds more creatures
      system.addCreature(movementPerlin, o);

      seedx += 1;
      seedy += 10;
    }
  }
  //move landscape but keep creatures
  if (key == 'm') {
    //clear friction so creatures move free
    structure.clearStructure();
    structure.makeStructure();
    system.clearFriction();
  }
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
  float len;
  float k = 0.2f;
  //mouse svg
  PShape hands;

  Attractor(float _x, float _y) {
    location = new PVector(_x, _y);
    mass = 1;
    G = 1;
    dragOffset = new PVector(0.0f, 0.0f);
    len = 10;
    //Hands designed by R\u00e9my M\u00e9dard from The Noun Project
    hands = loadShape("grab.svg");
  }

  // Calculate spring force
  public void connect(Creature c) {
    // Vector pointing from anchor to bob location
    PVector force = PVector.sub(c.location, location);
    // What is distance
    float d = force.mag();
    // Stretch is difference between current distance and rest length
    float stretch = d - len;

    // Calculate force according to Hooke's Law
    // F = k * stretch
    force.normalize();
    force.mult(-1 * k * stretch);
    c.applyForce(force);
  }
  public void display() {
    shape(hands,location.x,location.y, 50,50);
//    fill(255);
//    ellipse(location.x, location.y, 10, 10);
  }
  //Returns PVector that represents magnitude of attract force for a Creature
  public PVector attract(Creature m) {
    PVector force = PVector.sub(location, m.location);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 0.0f, 10.0f);    // Limiting the distance to eliminate "extreme" results for very close or very far objects

    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G) / (d * d);      // Calculate gravitional force magnitude
    force.mult(strength);                                  // Get force vector --> magnitude * direction

    return force;
  }
}

/**
 
 This is the main Creature class. 
 A Creature can belong to a CreatureSystem. All forces acted upon Creatures within a CreatureSystem are updated here. Creatures explore the space belonging to a certian Landscape
 and have a certain Movement that determines the way they move around the Landscape. A Creature initially flickers randomly and moves around bumping into
 FrictionSpaces, part of FrictionStructure's making music and illuminating the background. Some Creatures are attracted to an Attractor object that is moved by the user. As Creatures
 explore, they build halos of illumination that show them what structures are around them that they have not hit. They get also begin to fade and die in the CreatureSystem.
 
 **/
class Creature {
  //movement associated with creature
  Movement m; 
  //landscape associated with creature
  Landscape l; 
  PVector location, velocity, acceleration, resistance, attracted, curiosity;
  //set max speed for velocity
  int maxSpeed, maxForce; 
  float lifeforce;
  float frictionValue;
  float MAXLIFESPAN = 3000;
  float size;
  boolean blink;

  Random generator = new Random();
  float gaus = (float) generator.nextGaussian();

  float spirit;
  float sdSpirit = 25;   // Define a standard deviation
  float meanSpirit = 500;   // Define a mean value 
  
  float gausColor;
  float sdColor = 55;
  float meanColor = 200;

  int totalSpacesExplored;

  Creature(Movement defaultM, Landscape defaultL) {
    m = defaultM; //set initial movement
    l = defaultL; //set initial landscape
    maxSpeed = 2; //set max speed
    maxForce = 2;
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps)
    resistance = new PVector(0, 0);
    curiosity = new PVector(0.001f, 0.001f);
    attracted = l.getAttractor().location; //set attractor to landscape-default
    lifeforce = MAXLIFESPAN;
    frictionValue = 0;
    spirit = ( gaus * sdSpirit ) + meanSpirit;
    totalSpacesExplored = 0;
    blink = true;
  }
  Creature(Movement defaultM) {
    m = defaultM; //set initial movement
    l = new Landscape(); //set initial landscape
    maxSpeed = 1; //set max speed
    maxForce = 2;
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps)
    resistance = new PVector(0, 0);
    curiosity = new PVector(0.001f, 0.001f);
    attracted = l.getAttractor().location; //set attractor to landscape-default
    lifeforce = 255;
    frictionValue = 0;
    spirit = ( gaus * sdSpirit ) + meanSpirit;
    totalSpacesExplored = 0;
    blink = true;
  }

  public void update() {

    //apply friction
    PVector friction = velocity;
    friction.mult(-1); 
    friction.normalize();
    friction.mult(frictionValue);
    println(friction);
    applyForce(friction);


    // only apply attraction if spirit is below 300 and without exposure to other places, otherwise decrement spirit (and apply curiousity force) IDEA: some creatures should never move toward the attractor
    if (spirit < 300) { // && totalSpacesExplored == 0 is this problematic? What if spirit is less than 300 and previously 0 places were explored but now one is, will the attracted location be wrong?

/** Debugging      
//      if(!withoutSpirit.contains(this)){
//        withoutSpirit.add(this);
//      }
**/
      attracted = l.getAttractor().location; //get the current location of the attractor for landscape
      PVector desired = PVector.sub(attracted, location); //target is the attracted creatures or inanimate attracted objects location
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxForce);
      applyForce(steer);
    }
    else { //apply some acceleration based on total squares explored that have been touched by each creature or willingness to not be attracted as related to total spaces explored
      //curiousity points to the bottom right, IDEA: Make fireflies more likely explore unexplored areas with more spirit and more places explored
      //      applyForce(curiosity);
      
      /** Really cool shape, too computationally taxing
      //      float angle = 0;
      //      float angleVel = 0.2;
      //      float amplitude = 10;
      //      beginShape();
      //      stroke(0, 255, gausColor);
      //      for (int x = 0; x <= location.x; x += 5) {
      //        float y = map(sin(angle), -1, 1, 0, location.y);
      //        vertex(x, y);//      With beginShape() and endShape(), you call vertex() to set all the vertices of your shape.
      //        angle +=angleVel;
      //      }
      //      endShape();
      **/
      PVector randomDirection = new PVector(random(-1.0f,1.0f),random(-1.0f,1.0f));
      applyForce(randomDirection);
      spirit--;
    }

    //apply movement associated with current creature
    applyForce(m.applyMovement()); 

    //all creatures apply resistance
    applyForce(resistance); 

    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);

    //decrease lifeforce
    lifeforce = lifeforce - 2;
  }
  public void display() {
    /**
     Alt design
     fill(255, opacity);
     ellipse(location.x + 2, location.y - 5, 5, 5);
     fill(200, 200, 20, opacity);
     ellipse(location.x, location.y, random(5, 20), 10);
     **/

    /**size is randomized, make it syncronized over time, 
     change from random to gaussian to absolute values, iterate through an array that has 1 through 12, randomly iterate though it to determine size, then at some point
     maybe when lifeforce is at a certain level, start limiting the options of randomness
     **/

    //size of firefly creature determined by random generator for un-patterned flickering effect
    float randomSize = random(12);

    //calculate size in a gaussian distribution for more ordered flickering effect
    gaus = (float) generator.nextGaussian();
    float sdSize = 4;
    float meanSize = 6;
    float gausSize = ( gaus * sdSize ) + meanSize;

    //calcluate gaussiacolor for firefly halos
    gaus = (float) generator.nextGaussian();
    gausColor = ( gaus * sdColor ) + meanColor;

    //if spirit is greater than 300 use random flickering pattern, otherwise occilate between size 6 and 15 for a standardized flicker simulating emergence
    if (spirit > 300) {
      //size = gausSize;
      size = randomSize;
    }
    else {
      if (blink) {
        size = 6;
        blink = false;
      }
      else {
        size = 10;
        blink = true;
      }
    }

    //map lifeforce to opacity to fade when they get older and die :(
    float opacity = map(lifeforce, 0, MAXLIFESPAN, 0, 255);
    stroke(255, 255, 200, opacity);
    strokeWeight(2);
    fill(255, 255, 100, opacity);
    ellipse(location.x, location.y, size, size);

    fill(255, 10);
    //make stroke color change with a gaussian pattern
    stroke(255, gausColor, gausColor, opacity);
    //halo showing how much exploration and enlightment the creatures have
    ellipse(location.x, location.y, size + totalSpacesExplored*4, size + totalSpacesExplored*4);
  }
  public void applyForce(PVector force) {
    acceleration.add(force);
  }
  //if lifeforce is 0 then the firefly is dead
  public boolean isDead() {
    return lifeforce == 0;
  }
  // assign Creature with particular movement (i.e. Perlin, Random)
  public void setMovement(Movement _m) {
    m = _m;
  }
  // returns the current movement applied to the Creature
  public Movement getMovement() {
    return m;
  }
  // assign Creature with particular Landcape (movement bounds)
  public void setLandscape(Landscape _l) {
    l = _l;
  }
  // returns the current landscape (movement bounds) applied to the Creature
  public Landscape getLandscape() {
    return l;
  }
  //return attracted force as PVector 
  public PVector getAttractorForce() { 
    return attracted;
  }
  //set attractor force for landscape's attractor
  public void setAttractorForce(PVector _attracted) { 
    attracted = _attracted;
  }
  //set the friction value applied to the acceleration to 0
  public void clearFriction() {
    frictionValue = 0;
  }
  //increment the spaces explored by the particular creature
  public void exploredSpace() {
    totalSpacesExplored++;
  }
}

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
  public void addCreature(Movement _m, Landscape _l) {
    system.add(new Creature(_m, _l));
  }
  //clears friction values for all creatures so they can fly freely
  public void clearFriction() {
    Iterator<Creature> it = system.iterator();
    while (it.hasNext ()) {
      Creature c = it.next();
      c.clearFriction();
    }
  }
  //runs through all creatures and updates their locations and removes them if necessary
  public void run() {
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
  public void addWind(String s) {
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
  public void clearSystem() {
    system.clear();
  }
}

/**

This class creates a FrictionSpace object which is a square in a location with different
friction values associated which act upon the Creatures that fall within them. 
FrictionSpace's contain and are bumped by Creatures,
which turn blue and make a sound when they are hit.

**/
class FrictionSpace {

  float x, y, w, h;
  PVector l;
  float c;
  float xoff = 0.1f;
  PVector location; 
  boolean isBumped;
  boolean visitedBefore;
  boolean withinHalo;

  //construct landscape with particular size, location and friction value
  FrictionSpace(float _x, float _y, float _w, float _h, float _c) {
    location = new PVector(_x, _y);  
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    isBumped = false;
    visitedBefore = false;
    withinHalo = false;
  }
  //change color if mover has hit landscape
  public void displayTouched() {
    noStroke();
    fill(0, random(200) + (noise(xoff)*255)%255, random(200) + (noise(xoff)*255)%255);
    rect(x, y, w, h);
    xoff++;
  }
  //display landscape
  public void display() {
    //if friction space is within halo of creature, illuminate slightly
    noStroke();

    if (withinHalo()) {
      fill(100, 0, 100, 30);
      rect(x, y, w, h);
      //hides illuminated spaces immediately after showing them, IDEA: make them last only for a little while
//      withinHalo = false;
    }
    else {
      fill(255,100);
      rect(x, y, w, h);
    }
    xoff++;

    /**
     Alt design
     fill(100,0,100, 90);
     fill((random(200) + (noise(xoff)*255))%255, (random(200) + (noise(xoff)*255))%255, 0);
     **/
  }

  public void update() {
  }

  public boolean withinHalo() {
    return withinHalo;
  }

  //does landscape contain a particular mover?
  public boolean contains(Creature m) {
    l = m.location;
    //if isBumped is true then this frictionspace has been visited before
    if (isBumped) {
      visitedBefore = true;
    }
    //the space falls within a Creatures halo of illumination, based on the total squares explored, withinHalo is true
    if (l.x + m.totalSpacesExplored > x && l.x + m.totalSpacesExplored < x + w && l.y + m.totalSpacesExplored > y && l.y + m.totalSpacesExplored < y + h) {
      withinHalo = true;
    }
    //Creature's location falls within FrictionSpace
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      isBumped = true;
      return true;
    }
    else {
      return false;
    }
  }
  //Returns whether landscape has been bumped at least once in order to change color in display
  public boolean bumped() {
    return isBumped;
  }
  //Returns whether FrictionSpace has been visited more than once, important for triggering sounds in FrictionStructure
  public boolean visitedBefore() {
    return visitedBefore;
  }
}

/**
 
 This class creates a FrictionStructure object which is a collection of FrictionSpaces with changing formations.
 
 **/
class FrictionStructure {

  ArrayList<FrictionSpace> landscapes = new ArrayList<FrictionSpace>();
  int randomSound;
  int n = 0;
  float frictionDecrease;
  float frictionIncrease;
  float c = 0.2f;

  FrictionStructure() {
//    frictionDecrease = 3.5;
//    frictionIncrease = 1.0;
    frictionDecrease = 0;
    frictionIncrease = 0;
  }
  //what will change about the structure? Will it move?
  public void update() {
  }
  //display FrictionSpaces that have been touched
  public void display() {
    for (FrictionSpace landscape : landscapes) {
      if (landscape.bumped()) {
        landscape.displayTouched();
      }
      else {
        landscape.display();
      }
    }
  }
  //clear entire structure of FrictionSpaces
  public void clearStructure() {
    landscapes.clear();
  }
  //Cycles through friction spaces and checks if current Creature falls within it
  public void contains(Creature _c) {
    for (FrictionSpace landscape : structure.landscapes) {
      //if landscape contains a creature, play the random sound and lighten the background color value
      if (landscape.contains(_c)) { 
        //assign friction value of current space to Creature's forces
        _c.frictionValue = landscape.c;

/**trying to make rules about what sounds are called when
//        if (landscape.c == 0.0) {
//          randomSound = 1;
//        }
//        else {
//          randomSound = int(random(sampleList.size()/2, sampleList.size()));
//        }
**/     
        //map sound to level of friction
        randomSound = PApplet.parseInt(map(landscape.c,frictionDecrease,frictionIncrease,0,sampleList.size() - 1));
        
        //if landscape has been explored already don't make a sound
        if (!landscape.visitedBefore()) {
          //increment total explored space for Creature
          _c.exploredSpace();
          //play sound
          sampleList.get(randomSound).trigger();
          sampleList.get(randomSound).setGain(0.4f);
          //make background lighter
          ground = ground + 1;
        }
      }
    }
  }
  //construct FrictionStructure landscape
  public void makeStructure() {

    //limit what n can be to avoid moving too far off screen or make an edges method to scale within bounding box
    n = n%35;

    for (int i=0;i< random(40);i++) {

      //could make landscape objects long lines of conjoined squares instead of initializing them this way
      landscapes.add(new FrictionSpace(0+n, 70+n, 5, 5, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 100+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 130+n, 10, 10, frictionDecrease));

      landscapes.add(new FrictionSpace(0+n, 200+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 230+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 260+n, 10, 10, frictionDecrease));

      landscapes.add(new FrictionSpace(70+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(100+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(130+n, 0+n, 10, 10, frictionDecrease));

      landscapes.add(new FrictionSpace(200+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(230+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(260+n, 0+n, 10, 10, frictionDecrease));

      //--------------------------------------------------------------------

      landscapes.add(new FrictionSpace(width-n, height-70-n, 5, 5, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-100-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-130-n, 10, 10, frictionIncrease));

      landscapes.add(new FrictionSpace(width-n, height-200-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-230-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-260-n, 10, 10, frictionIncrease));

      landscapes.add(new FrictionSpace(width-70-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-100-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-130-n, height-0-n, 10, 10, frictionIncrease));

      landscapes.add(new FrictionSpace(width-200-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-230-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-260-n, height-0-n, 10, 10, frictionIncrease));
      n += 10;
      frictionIncrease++;
      frictionDecrease--;
    }
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
    fill(255);
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
    lHeight = height; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 0); //default
  }
  public void update() {
    angle = angle + 0.02f; //update angle to cause wave motion
  }
  public void display() {
    noStroke();
    fill(255);
    a.display();
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

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Ecosystem_v2_fireflies" });
  }
}
