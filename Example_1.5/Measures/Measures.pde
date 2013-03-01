/**
* Title: "Measures"
* Author: Maya Richman
* Date: February 2, 2013
**/
//Original Code:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-5: Vector magnitude

void setup() {
  size(800, 200);
  smooth();
  background(255);
}

void draw() {
//add functionality that erases screen when every pixel is covered in a circle
  PVector mouse = new PVector(mouseX, mouseY);
  PVector center = new PVector(width/2, height/2);
  mouse.sub(center);
  //mouse.limit(100);
  //mouse.rotate(1);
  float m = mouse.mag();
  fill(0, 10);
  noStroke();
  rect(0, 0, m, 10);
  chart(m);
  translate(width/2, height/2);
  stroke(0, 10);
  strokeWeight(2);
  line(0, 0, mouse.x, mouse.y);
}

void chart(float m) {
  smooth();
  noStroke();
  fill(255, 0, 0, 2);
  ellipse(0, 180, m, m);
}

