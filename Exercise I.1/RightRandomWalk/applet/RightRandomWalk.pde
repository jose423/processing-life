/**
* Title: Son Set
* Name: Maya Richman
* Date: January 20, 2013
* Assignment 2-Ex. I.1
**/
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;

void setup() {
  size(400,400);
  frameRate(30);
  // Create a walker object
  w = new Walker();

}

void draw() {
  background(255);
  // Run the walker object
  w.walk();
  w.draw();
}



