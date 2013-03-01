/**
* Title: Walking Cloud
* Name: Maya Richman
* Date: January 14, 2013
* Assignment 1-a
**/

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;
int opacity = 100;

void setup() {
  size(500,500);
  background(65,129,254); //changed to bright blue
  // Create a walker object
  w = new Walker();
}

void draw() {
    // Run the walker object
  w.step();
  w.render();
 }


