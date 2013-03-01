/**
* Author: Maya Richman
* Title: Ecosystem v.1.
* Date: Feb 25, 2013
**/

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
  float creatureSize;

  Mover(Landscape l, int age, float spirit) {
    super(l, age);
    location = new PVector(l.getCenterX(), l.getCenterY()); //Vector determines location of mover
    velocity = new PVector(0, 0, 0.1); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps) 
    mass = 2*age; //start with mass equal to 1
    this.spirit = spirit;
    this.age = age;
    this.l = l;
    maxspeed = 5;
    maxforce = 0.2;
    this.r = 127; 
    this.g = 0;
    this.b = 255;
    r2 = 6.0;
    creatureSize = age*2;
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impace (1/100) vs. (1/1000)
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(30.0);
    acceleration.mult(0); //resets acceleration
  }
  //base off of spirit, less spirit more likely to follow pvector target
  void seek(PVector target) {
    PVector desired = helperReaction(target);
    PVector steer = PVector.sub(desired, velocity);
    //desired.mult(0);

    steer.limit(maxforce);
    desired.limit(maxforce);

    applyForce(steer);
    applyForce(desired);

    if ((creatureSize+0.2)%40.0 > 1.0) {
      creatureSize = (creatureSize+0.002)%40.0;
    }
    else {
      creatureSize = 40.0;
    }
  }
  void flee(PVector target) {
    PVector desired = helperReaction(target);
    //PVector steer = PVector.add(desired, velocity);
    //steer.limit(0.02);
    desired.limit(0.02);

    //applyForce(steer);
    applyForce(desired);
    
    if((creatureSize+0.2)%10.0 > 1.0){
    creatureSize = (creatureSize-0.002)%10.0; //cool popping effect when reaches 10 x 10
    }
    else{
     creatureSize = 10.0; 
    }
    //creatureSize = (creatureSize-0.2)/10.0; //cool popping effect when reaches 10 x 10
  }
  PVector helperReaction(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    float modifiedSpeed = map(this.getSpirit(), 0, 100, 1, maxspeed);
    desired.mult(modifiedSpeed);  
    return desired;
  }
  void display() {
    stroke(0);
    strokeWeight(1);
    fill(r, g, b, 80); 
    //change size by velocity

    ellipse(location.x, location.y, creatureSize, creatureSize);
  }

  void checkEdges() {

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
  void checkEdges(Landscape l) {

    //width and height should depend on the center of the oce
    //add  width to PVector oceanCenter
    if (location.x > l.getCenterX() + float(l.getHeight())) {
      velocity.x *= -0.3;
      location.x = float(l.getHeight()) + l.getCenterX(); //float(l.getHeight())
    }  
    else if (location.x < l.getCenterX() + float(l.getHeight()) && location.x < l.getCenterX() ) {
      velocity.x *= -0.3;
      location.x = l.getCenterX();
    }
    if (location.y > (float(l.getWidth()) + l.getCenterY())) {
      velocity.y *= -1;
      location.y = float(l.getWidth()) + l.getCenterY();
    }
    else if (location.y < (float(l.getWidth()) - l.getCenterY()) && location.y < l.getCenterY()) {      
      velocity.y *= -1;
      location.y = l.getCenterY();
    }
  }

  float getSpirit() {
    return spirit;
  }
  void setSpirit(float s) {
    spirit = s;
  }
  void agitate() {
    velocity.mult(1.2);
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
  PVector getLocation(){
    return location;
  }
}

