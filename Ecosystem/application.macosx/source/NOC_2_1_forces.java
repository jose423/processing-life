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

public class NOC_2_1_forces extends PApplet {

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

public void setup() {
  size(700, 700); //set size of sketch
  o = new Ocean(width, height); //construct Ocean landscape of type Landscape with given size
  l = new Land(130, height); //construct a Land of type Landscape with given size
  ourMoon = new Moon(); //construct Moon to determine tide patterns for Ocean objects
  s = new Sun();
  smooth();
  wind = new PVector(0.002f, 0.01f); //construct uniform wind force
  gravity = new PVector(0, 0.003f); //construct uniform gravity force
  resistance = new PVector(0.04f, 0); //construct uniform resistance force for Creatures

  //construct all movers with Landscape Ocean and fill array
  for (int i = 0; i<totalMovers; i++) {
    allOceanMovers[i] = new Mover(o, PApplet.parseInt(random(4, 10)), random(100.0f)); //randomize the age between 4 and 10 (which affects mass and size) and randomize spirit value [0,100] **put method that ages
    allMovers[i] = allOceanMovers[i]; //fill allMovers array
  }
  int tempTotal = allOceanMovers.length; //starting value for next for loop

  for (int i = 0; i<totalMovers; i++) {
    allGroundMovers[i] = new Mover(l, PApplet.parseInt(random(4, 10)), random(100.0f)); //randomize the age between 4 and 10 (which affects mass and size) and randomize spirit value [0,100] **put method that ages

    allMovers[tempTotal] = allGroundMovers[i]; //fill allMovers array of Creatures
    tempTotal++;
  }
  l.display(); //show land
  currentTide = o.checkTide(ourMoon);  //too much in one method? checks tide of particular moon
  o.update();
  o.display();
  s.update();
}

public void draw() {
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

      if ( allMovers[i].getSpirit() < 50.0f) {
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

        resistance.mult(abs((allMovers[i].getSpirit()/100.0f)));
        allMovers[i].applyForce(resistance);
        allMovers[i].setSpirit(abs(allMovers[i].getSpirit() - 0.02f));
      }
      else {
        resistance.div(1.001f);
        allMovers[i].applyForce(resistance);
      }
    }
    allMovers[i].update(); //show all movers (eventually show movers only with display of landscape to avoid showing movers on the wrong landscape with overlap
    allMovers[i].display();

    allMovers[i].checkEdges(allMovers[i].getMoverLandscape()); //each mover has a landscape involved with it's constructor
  }
    s.update();

}
public void mousePressed() {
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

abstract class Creature {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float spirit;
  int age;
  Landscape l;
  int x = 0;
  int maxspeed;
  float maxforce;
  int r, g, b;

  Creature(Landscape l, int age) {
    location = new PVector(l.getCenterX(), l.getCenterY()); //Vector determines location of mover
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps) 
    mass = 2*age; //start with mass equal to 1
    spirit = 100.0f;
    this.age = age;
    this.l = l;
    maxspeed = 20;
    maxforce = 0.f;
    this.r = 127; 
    this.g = 0;
    this.b = 255;
  }
  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impace (1/100) vs. (1/1000)
    acceleration.add(f);
  }
  //base off of spirit, less spirit more likely to follow pvector target
  public void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    println(maxspeed);
    //map maxspeed relative to spirit
    float modifiedSpeed = map(this.getSpirit(), 0.0f, 100.0f, 0, maxspeed);
    desired.mult(PApplet.parseInt(maxspeed));
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  public void flee(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    float modifiedSpeed = map(this.getSpirit(), 0, 100, 1, maxspeed);
    desired.mult(PApplet.parseInt(modifiedSpeed));
    PVector steer = PVector.add(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  public void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0); //resets acceleration
  }

  public void display() {
    stroke(0);
    strokeWeight(2);
    fill(127, 0, 255);
    ellipse(location.x, location.y, age*2, age*2);
  }
  public void checkEdges(Landscape l) {
    //width and height should depend on the center of the oce
    //add  width to PVector oceanCenter
    if (location.x > l.getCenterX() + PApplet.parseFloat(l.getHeight())) {
      velocity.x *= -0.3f;
      location.x = PApplet.parseFloat(l.getHeight()) + l.getCenterX();
      print("In if for x: " + x);
    }  
    else if (location.x < l.getCenterX() + PApplet.parseFloat(l.getHeight()) && location.x < l.getCenterX() ) {
      velocity.x *= -0.3f;
      location.x = (PApplet.parseFloat(l.getHeight())) + l.getCenterX();
      print("In else if for x: " + x);
    }

    if (location.y > (PApplet.parseFloat(l.getWidth()) +  l.getCenterY())) { //
      velocity.y *= -1;
      location.y =  PApplet.parseFloat(l.getWidth()) + l.getCenterY(); //
      print("In if for y: " + x);
    }
    else if (location.y < (PApplet.parseFloat(l.getWidth()) - l.getCenterY()) && location.y < l.getCenterY()) {      
      velocity.y *= -1;
      location.y = l.getCenterY();
      print("In else if for y: " + x);
    }

    x++;
  }
  public float getSpirit() {
    return spirit;
  }
  public void setSpirit(float s) {
    spirit = s;
  }
  public void agitate() { //set boundaries
    velocity.mult(1.2f);
    velocity.normalize();
  }
  public void setColor(int _r, int _g, int _b) {
    r = _r;
    g = _g;
    b = _b;
  }
  public Landscape getMoverLandscape() {
    return l;
  }
  public void setMoverLandscape(Landscape _l){
    this.l = _l;
  }
}

class Land extends Landscape {
  PVector centerGround;
  int groundh, groundw;
  
  Land (int groundh, int groundw) {
    super(groundh, groundw);
    this.groundh = groundh;
    this.groundw = groundw;
    centerGround = center;
  }
  public void display() {
    fill(100, 150, 0);
    noStroke();
    rect(centerGround.x, centerGround.y, groundh, groundw);
  }
  public float getCenterX() {
    return centerGround.x;
  }
  public float getCenterY() {
    return centerGround.y;
  }
    public int getWidth() {
    return groundw;
  }
  public int getHeight() {
    return groundh;
  }

}

abstract class Landscape {
  int lwidth, lheight;
  PVector center;
  Landscape(int lWidth, int lHeight) {
    this.lwidth = lWidth;
    this.lheight = lHeight;
    center = new PVector(0.0f, 0.0f);
  }
  public int getWidth() {
    return lwidth;
  }
  public int getHeight() {
    return lheight;
  }
  public float getCenterX() {
    return center.x;
  }
  public float getCenterY() {
    return center.y;
  }
  public void display() {
    fill(100, 150, 0);
    noStroke();
    rect(center.x, center.y, lheight, lwidth);
  }
}

//isn't changing direction the earth moves and tides are affected
class Moon{
 float direction;
 
  Moon(){
    direction = 45.0f; 
  } 
  public float getDirection(){
   return direction; 
  }
}
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover extends Creature {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float spirit;
  int age;
  Landscape l;
  int maxspeed;
  float maxforce;
  int r, g, b;
  float r2;
  int x = 1;

  Mover(Landscape l, int age, float spirit) {
    super(l, age);
    location = new PVector(l.getCenterX(), l.getCenterY()); //Vector determines location of mover
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps) 
    mass = 2*age; //start with mass equal to 1
    this.spirit = spirit;
    this.age = age;
    this.l = l;
    maxspeed = 5;
    maxforce = 0.1f;
    this.r = 127; 
    this.g = 0;
    this.b = 255;
    r2 = 6.0f;
  }
  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impace (1/100) vs. (1/1000)
    acceleration.add(f);
  }

  public void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(2.0f);
    acceleration.mult(0); //resets acceleration
  }
  //base off of spirit, less spirit more likely to follow pvector target
  public void seek(PVector target) {
    PVector desired = helperReaction(target);
    PVector steer = PVector.sub(desired, velocity);
    //    desired.mult(0);
    steer.limit(maxforce);
    desired.limit(maxforce);
    applyForce(steer);
    applyForce(desired);
  }
  public void flee(PVector target) {
    PVector desired = helperReaction(target);
    PVector steer = PVector.add(desired, velocity);
    steer.limit(maxforce);
    desired.limit(maxforce);

    applyForce(steer);
    applyForce(desired);
  }
  public PVector helperReaction(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    float modifiedSpeed = map(this.getSpirit(), 0, 100, 1, maxspeed);
    desired.mult(modifiedSpeed);  
    return desired;
  }
  public void display() {
    stroke(0);
    strokeWeight(1);
    fill(r, g, b, 80); 
    ellipse(location.x, location.y, age*2, age*2);
  }

  public void checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } 
    else { 
      if (location.x < 0) {
        velocity.x *= -1;
        location.x = 0;
      }
    }
    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
  public void checkEdges(Landscape l) {

    //width and height should depend on the center of the oce
    //add  width to PVector oceanCenter
    if (location.x > l.getCenterX() + PApplet.parseFloat(l.getHeight())) {
      velocity.x *= -0.3f;
      location.x = PApplet.parseFloat(l.getHeight()) + l.getCenterX(); //float(l.getHeight())
    }  
    else if (location.x < l.getCenterX() + PApplet.parseFloat(l.getHeight()) && location.x < l.getCenterX() ) {
      velocity.x *= -0.3f;
      location.x = l.getCenterX();
    }
    if (location.y > (PApplet.parseFloat(l.getWidth()) + l.getCenterY())) {
      velocity.y *= -1;
      location.y = PApplet.parseFloat(l.getWidth()) + l.getCenterY();
    }
    else if (location.y < (PApplet.parseFloat(l.getWidth()) - l.getCenterY()) && location.y < l.getCenterY()) {      
      velocity.y *= -1;
      location.y = l.getCenterY();
    }
  }

  public float getSpirit() {
    return spirit;
  }
  public void setSpirit(float s) {
    spirit = s;
  }
  public void agitate() {
    velocity.mult(1.2f);
  }
  public void setColor(int _r, int _g, int _b) {
    r = _r;
    g = _g;
    b = _b;
  }
  public Landscape getMoverLandscape() {
    return l;
  }
  public void setMoverLandscape(Landscape _l) {
    this.l = _l;
  }
}

/*
This object represents a variable space that will change upon other factors with methods, i.e. wind and time of day
 
 The basic components of an ocean:
 size
 */

class Ocean extends Landscape {
  PVector centerOcean;
  float directionFromMoon;
  int x = 1;
  int oceanh, oceanw;

  Ocean(int oceanw, int oceanh) {
    super(oceanw, oceanh);
    this.oceanw = oceanw;
    this.oceanh = oceanh;
    centerOcean = new PVector(width/5, 0);
    directionFromMoon = 0.0f;
  }

  public void display() {
    fill(0, 100, 230);
    noStroke();
    rect(centerOcean.x, centerOcean.y, oceanh, oceanw);
  }

  public void update() {
    fill(0, 100, 230);
    noStroke();

    rect(centerOcean.x, centerOcean.y, oceanh, oceanw);
    directionFromMoon++;
    directionFromMoon = directionFromMoon%720;
  }
  //checks tide of ocean and moves accordingly, assumes moon is at 45degrees
  public boolean checkTide(Moon m) {
    //if high tide return 1
    if (directionFromMoon >= m.getDirection()*14 || directionFromMoon <= m.getDirection()*6) { //equal parts moving toward moon 
      return true;
    }
    else {     //if low tide return 0
      if (directionFromMoon > m.getDirection()*6 || directionFromMoon < m.getDirection()*14) {
        return false;
      }
      return false;
    }
  }
  public void updateTide(Moon m){
    x++;
    //if high tide return 1
    if (directionFromMoon >= m.getDirection()*14 || directionFromMoon <= m.getDirection()*6) { //equal parts moving toward moon 
      centerOcean.div(1.001f); //move toward moon
    }
    else {     //if low tide return 0
      if (directionFromMoon > m.getDirection()*6 || directionFromMoon < m.getDirection()*14) {
        centerOcean.mult(1.001f); //move away from moon
      }
    }    
  }
  public float getCenterX() {
    return centerOcean.x;
  }
  public float getCenterY() {
    return centerOcean.y;
  }
}

/**
 Class that changes the gradient of colors on the land and ocean and movers?, shadow?
 **/
class Sun {
  // Constants
  int Y_AXIS = 1;
  int X_AXIS = 2;
  int b1, b2, c1, c2;


  Sun() {
    // Define colors
    b1 = color(255);
    b2 = color(0);
    c1 = color(255,215,0);
    c2 = color(255, 0, 153);
  }
  public void update() {
    // Foreground
    setGradient(50, 90, 540, 80, c1, c2, Y_AXIS);
  }

  public void setGradient(int x, int y, float w, float h, int c1, int c2, int axis ) {

    noFill();

    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        int c = lerpColor(c1, c2, inter);
        stroke(c);
        //ellipse(x, i, x+w, i);
        //ellipse(x, x+w, i, i);
        fill(c,2);
        ellipse(width - width/5,height - height/5,i,i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        int c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "NOC_2_1_forces" });
  }
}
