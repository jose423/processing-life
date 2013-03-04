/**
 * Title: Ahh
 * Author: Maya Richman
 **/
//Original
// Daniel Shiffman
// The Nature of Code
// http://natureofcode.com

//running on the sidewalk really fast

Noise noise1, noise2;
Divider d1,d2,d3;
float center = 400;

void setup() {
  size(800, 400);
  //noise1 = new Noise(0.1, 5, 0.2, 0.0, 0.0);
  noise2 = new Noise(0.9, 1, 0.8, 0.2, 0.1);
  d1 = new Divider(center,50,0,3.0);
  d2 = new Divider(center,200,0,3.2);
  d3 = new Divider(center,300,0,3.7);
}

void draw() {
  background(255);
  //noise1.draw();
  noise2.draw();
  d1.draw();
  d2.draw();
}

