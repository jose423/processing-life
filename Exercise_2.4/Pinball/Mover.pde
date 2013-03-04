/**
 * Author: Maya Richman
 * Date: March 1, 2013
 * Title: Pinball Wizard Movers
 * Original Code from Daniel Shiffman
 **/

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float fillR, fillG, fillB;
  
  Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    fillR= random(255);
    fillG = random(255);
    fillB= random(255);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0, fillG, fillB, 127);
    ellipse(location.x, location.y, mass*14, mass*14);
    smooth();
  }

  boolean checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
      return false;
    } 
    else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;      
      return false;
    }
    if (location.y > height) {
      velocity.y *= -1;
      return true;
    }
    return false;
  }
}

