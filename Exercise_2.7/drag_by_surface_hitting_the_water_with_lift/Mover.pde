/*
* Author: Maya Richman
* Title: These Great Heights-Boxes
* Date: March 2, 2013
* Original: Daniel Shiffman
*/

class Mover {

  // location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  // Mass is tied to size
  float mass;
  int whBox;
  int liquidSide;
  
  Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    whBox = int(random(mass*16));
    liquidSide = whBox-(whBox/2);
  }

  // Newton's 2nd law: F = M * A
  // or A = F / M
  void applyForce(PVector force) {
    // Divide by mass 
    PVector f = PVector.div(force, mass);
    // Accumulate all forces in acceleration
    acceleration.add(f);
  }

  void update() {
    
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Location changes by velocity
    location.add(velocity);
    // We must clear acceleration each frame
    acceleration.mult(0);
  }
  
  // Draw Mover
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127,0,3, 200);
    rect(location.x, location.y, whBox,liquidSide);
  }
  
  // Bounce off bottom of window
  void checkEdges() {
    if (location.y > height) {
      velocity.y *= -0.6;  // A little dampening when hitting the bottom
      location.y = height;
    }
  }
}


