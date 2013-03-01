/**
 * Author: Maya Richman
 * Title: Abstract Tennis ball
 * Date: January 25, 2013
 **/
//Original Code
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover mover;

void setup() {
  size(800,200);
  mover = new Mover(); 
}

void draw() {
//  background(0);
  
  mover.update();
  mover.checkEdges();
  mover.display();
}

