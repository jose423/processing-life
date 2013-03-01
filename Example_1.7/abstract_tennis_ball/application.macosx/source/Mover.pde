/**
 * Author: Maya Richman
 * Title: Abstract Tennis ball
 * Date: January 25, 2013
 **/

/**
 *This sketch changes the size of the mover everytime it exceeds the height or width of the sketch
 *
 *Possible edit later: make it look like it is bouncing up and down with changing size and location and speed combined
 **/

//Original Code by
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  int ballSize = 48;
  float max;

  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-1, 5), random(-2, 2));
    acceleration = new PVector(-0.001, 0.01);
    max = 10;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(max);
    location.add(velocity);
  }

  void display() {
    smooth();
    stroke(255);
    strokeWeight(1);
    fill(127, 500, 30, 20);
    ellipse(location.x, location.y, ballSize, ballSize);
  }
  void speedUp() {
    velocity.x = velocity.x*2; 
    velocity.y = velocity.y*2;
  }

  void limit(PVector vector, float max) {
    if (vector.mag() > 10) {
      vector.normalize();
      vector.mult(max);
    }
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
      speedUp();
      ballSize=abs(ballSize-5);
    } 
    else if (location.x < 0) {
      location.x = width;
      ballSize=abs(ballSize-1);
    }

    if (location.y > height) {
      location.y = 0;
      ballSize=abs(ballSize-5);
      println(ballSize);
    } 
    else if (location.y < 0) {
      location.y = height;
      ballSize=abs(ballSize+1);
    }
  }
}

