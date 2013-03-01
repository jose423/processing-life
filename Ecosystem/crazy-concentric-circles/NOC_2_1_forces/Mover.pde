// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float spirit;
  int age;
  
  Mover() {
    location = new PVector(width/2, height/2); //Vector determines location of mover
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps) 
    mass = 1; //start with mass equal to 1
    spirit = 100.0;
    this.age = 1;
  }
  Mover(Ocean o, int age) {
    location = new PVector(o.getCenterX(), o.getCenterY()); //Vector determines location of mover
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps) 
    mass = 2*age; //start with mass equal to 1
    spirit = 100.0;
    this.age = age;
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impace (1/100) vs. (1/1000)
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0); //resets acceleration
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, age*10, age*10);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } 
    else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
  //check the boundaries for the paricular ocean (maybe change this to any landscape object eventually, landscape is an abstract class?
  void checkEdges(Ocean o) {

    //width and height should depend on the center of the oce
    //add  width to PVector oceanCenter
    if (location.x > o.getCenterX() + float(o.getHeight())) {
      velocity.x *= -0.3;
      location.x = float(o.getHeight()) + o.getCenterX();
    }  
    else if (location.x < o.getCenterX() + float(o.getHeight()) && location.x < o.getCenterX() ) {
      velocity.x *= -0.3;
      location.x = (float(o.getHeight())) + o.getCenterX();
    }
    if (location.y > (float(o.getWidth()) + o.getCenterY())) {
      velocity.y *= -1;
      location.y = float(o.getWidth()) + o.getCenterY();
    }
    else if (location.y < (float(o.getWidth()) - o.getCenterY()) && location.y < o.getCenterY()) {      
      velocity.y *= -1;
      location.y = o.getCenterY();
    }
  }
  float getSpirit() {
    return spirit;
  }
  void setSpirit(float s){
    spirit = s;
  }
  void agitate(){
   velocity.mult(1.2); 
  }
}

