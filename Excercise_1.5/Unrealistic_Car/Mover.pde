/**
* Author: Maya Richman 
* Title: Baby You Can Drive My Unrealistic Car
* Date: March 1, 2013
* Original: Daniel Shiffman
**/

//Press d to drive and b to brake

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  boolean brakesOn;

  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    topspeed = 6;
    acceleration = new PVector(0, 0);
    brakesOn = false;
  }

  void update() {
    //add a recoil for braking?
    if (brakesOn) {
      velocity.div(1.01);
      //close to completely stopping
      if (velocity.mag() < 0.03) {
        velocity.set(0.0, 0, 0);
        brakesOn = false;
      }
    }

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(70);
    ellipse(location.x, location.y, 35, 35);
    ellipse(location.x + 60, location.y, 35, 35);
    fill(127,200,100);
    noStroke();
    arc(location.x + 35, location.y - 5, 100, 90, PI, TWO_PI);
    fill(100);
    stroke(0);
    strokeWeight(2);
    ellipse(location.x + 10, location.y, 35, 35);
    ellipse(location.x + 70, location.y, 35, 35);

    smooth();
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } 
    else if (location.y < 0) {
      location.y = height;
    }
  }
  boolean brakesApplied() {
    return brakesOn;
  }
  void applyBrakes() {
    brakesOn = true;
  }
}

