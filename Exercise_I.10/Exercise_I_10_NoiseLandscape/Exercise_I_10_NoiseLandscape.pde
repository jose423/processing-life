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
  background(10,200,200);
  size(800, 200, P3D);

  // Create a landscape object
  water = new Landscape(20, 1000, 1000);
  belowWater = new Landscape(40, 800, 400);
  //land = new Landscape(30, 2000, 2000);
}

void draw() {

  // Ok, visualize the landscape space
  //background(255);
  pushMatrix();
  translate(width/2, height/2+20, -160);
  rotateX(PI/3);
  rotateZ(theta);
  belowWater.setColor(51, 82, 251);
  belowWater.render();
  water.setColor(0, 82, 251);
  water.render();
  //land.setColor(179, 119, 73);
  //land.render(); 
  popMatrix();

  water.calculate();
  belowWater.calculate();
  theta += 0.0025;
}

