/**
* Title: Eraserhead
* Name: Maya Richman
* Date: January 20, 2013
* Assignment 2-Ex. I.3
**/

//Original Code:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;

void setup() {
  size(400, 400);
  frameRate(30);
  background(235,0,90);
  // Create a walker object
  w = new Walker();
}

void draw() {
  smooth();
  // Run the walker object
  w.walk();
  w.draw();
}

void keyPressed() {
  if (key == CODED) { //left arrow decreases probability that walker will follow mouse, right increases
    if (keyCode == RIGHT) {
      if (w.prob < 1.0) {
        w.prob = w.prob + 0.1;       
        w.prob = (float)((int)(w.prob*10))/10;
      }
    }
    if (keyCode == LEFT) { 
      if (w.prob > 0.0) {
        w.prob = w.prob - 0.1;
      }
    }
  }
}

