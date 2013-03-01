/**
 Author: Maya
 Title: Invisible
 Date: Feb 20, 2013
 **/

// Originally
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector invisibleForce = new PVector(0.1, 0.1);
  float mass;
  float yDist = 50;
  float xDist = 40;

  Mover() {
    location = new PVector(30, 30);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = 10;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    invisibleForce.limit(-2);
//  invisibleForce.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, 48, 48);
  }

  void checkEdges() {

    //invisble force depends on how close the location.y is   
//    invisibleForce.set(-location.y/100, 0, 0); 
//    println(-location.y/10);
//    applyForce(invisibleForce);
//    invisibleForce.mult(0);
//
//    invisibleForce.set(-location.x/100, 0, 0); 
//    println(-location.x/10);
//    applyForce(invisibleForce);
//    invisibleForce.mult(0);

    if (location.x < width - yDist && location.x > 50) {
      invisibleForce.mult(2);
      applyForce(invisibleForce);
    }
    if (location.x > width - yDist) {
      location.x = width - yDist;
      velocity.x *= -1;
    } 
    else if (location.x < yDist) {
      velocity.x *= -1;
      location.x = yDist;
    }
    if (location.x < height - xDist && location.x > xDist) {
      invisibleForce.mult(2);
      applyForce(invisibleForce);
    }
    if (location.y > height - xDist) {
      velocity.y *= -1;
      location.y = height - xDist;
    }
    else if (location.y < xDist) {
      velocity.y *= -1;
      location.y = xDist;
    }
    println(invisibleForce);
  }
}

