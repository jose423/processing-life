/**
 * Author: Maya Richman
 * Title: Beach 
 * Date: January 28, 2013
 **/

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Landscape with height values according to Perlin noise

Landscape land, water, belowWater;    
float theta = 0.0;

void setup() {
  background(10, 200, 200);
  size(800, 200, P3D);
  // Create a landscape object
  water = new Landscape(40, 1000, 1000);
  belowWater = new Landscape(40, 1000, 1000);
  land = new Landscape(30, 2000, 2000);
}

void draw() {

  // Ok, visualize the landscape space
  background(255);
  pushMatrix();
  translate(width/2, height/2+20, -160);
  rotateX(PI/3);
  rotateZ(theta);
  belowWater.render();
  water.render();
  land.setColor(179, 119, 73,90);
  belowWater.setColor(51, 82, 251, 80);
  water.setColor(51, 82, 251, 60);
  land.render(); 
  popMatrix();

  water.calculate();
  belowWater.calculate();
  theta += 0.0025;
}

