/**
* Author: Maya Richman
* Title: Ecosystem v.1.
* Date: Feb 25, 2013
**/

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
  float creatureSize;

  Creature(Landscape l, int age) {
    location = new PVector(l.getCenterX(), l.getCenterY(), 2.0); //Vector determines location of mover
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps) 
    mass = 2*age; //start with mass equal to 1
    spirit = 100.0;
    this.age = age;
    this.l = l;
    maxspeed = 20;
    maxforce = 0.;
    this.r = 127; 
    this.g = 0;
    this.b = 255;
    creatureSize = age*2;
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impace (1/100) vs. (1/1000)
    acceleration.add(f);
  }
  //base off of spirit, less spirit more likely to follow pvector target
  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    //map maxspeed relative to spirit
    float modifiedSpeed = map(this.getSpirit(), 0.0, 100.0, 0, maxspeed);
    desired.mult(int(maxspeed));
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);

    creatureSize += 0.09;
  }
  void flee(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    float modifiedSpeed = map(this.getSpirit(), 0, 100, 1, maxspeed);
    desired.mult(int(modifiedSpeed));
    PVector steer = PVector.add(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);

    creatureSize -= 0.09;
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0); //resets acceleration
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127, 0, 255);
    ellipse(location.x, location.y, creatureSize, creatureSize);
  }
  void checkEdges(Landscape l) {
    //width and height should depend on the center of the oce
    //add  width to PVector oceanCenter
    if (location.x > l.getCenterX() + float(l.getHeight())) {
      velocity.x *= -0.3;
      location.x = float(l.getHeight()) + l.getCenterX();
    }  
    else if (location.x < l.getCenterX() + float(l.getHeight()) && location.x < l.getCenterX() ) {
      velocity.x *= -0.3;
      location.x = (float(l.getHeight())) + l.getCenterX();
    }

    if (location.y > (float(l.getWidth()) +  l.getCenterY())) { //
      velocity.y *= -1;
      location.y =  float(l.getWidth()) + l.getCenterY(); //
    }
    else if (location.y < (float(l.getWidth()) - l.getCenterY()) && location.y < l.getCenterY()) {      
      velocity.y *= -1;
      location.y = l.getCenterY();
    }

    x++;
  }
  float getSpirit() {
    return spirit;
  }
  void setSpirit(float s) {
    spirit = s;
  }
  void agitate() { //set boundaries
    velocity.mult(1.2);
    velocity.normalize();
  }
  void setColor(int _r, int _g, int _b) {
    r = _r;
    g = _g;
    b = _b;
  }
  Landscape getMoverLandscape() {
    return l;
  }
  void setMoverLandscape(Landscape _l) {
    this.l = _l;
  }
  PVector getLocation() {
    return location;
  }
}

