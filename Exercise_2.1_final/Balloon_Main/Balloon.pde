/**
Author: Maya Richman
Title: 99 Red Balloons
Date: February 20,2013
**/

/**
Constructs Balloon object that is red with a triangle
on the bottom that moves according to gravity, wind 
**/

class Balloon {

  PVector location, velocity, acceleration;  
  float r, g, b;

  Balloon(float _x) {
    location = new PVector(_x, height); //construct the Balloon starting at the height and location.x where mouse clicked
//    velocity = new PVector(0, -0.05);
    velocity = new PVector(0,0);
    acceleration = new PVector(0, 0);
    r = 245;
    g = 0;
    b = 0;
  }

  void display() {
    fill(r, g, b, 90);
    smooth();
    noStroke();
    ellipse(location.x, location.y, 50, 55); //draw ellipse
    fill(245, 0, 0, 90);
    //    translate(0, 40);
    triangle(location.x - 20, location.y + 40, location.x, location.y + 30, location.x + 20, location.y + 40); //make triangle bottom
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  //when balloon hits the top of the sketch where x <= 0, have bounce back, otherwise if balloon leaves screen delete from the arraylist of balloons
  boolean checkEdges() {
    if (location.y <= 0) { //if location.y of balloon has hit the top of the sketch or beyond, reverse velocity and slow
      velocity.y *= -0.6;
      location.y = 0;
      return false;
    }    
    if (location.x >= width || location.x <= 0) { //has moved passed left or right boundary, so return true to be removed from arraylist
      return true;
    }
    return false; //hasn't reached any boundary in this step
  }
  void changetoWhite() {
    r = 255;
    g = 255;
    b = 255;
  }
  void backtoRed() {
    r = 245;
    g = 0;
    b = 0;
  }
}

