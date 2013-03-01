/**
 * Author: Maya Richman
 * Title: Making Ice
 * Date: January 28, 2013
 **/
//Original from The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Landscape with height values according to Perlin noise

Landscape land, water, belowWater;    
float theta = 0.0;
int x;

void setup() {
  background(10, 200, 100);
  size(800, 200, P3D);
  // Create a landscape object
  water = new Landscape(40, 1000, 1000);
  belowWater = new Landscape(40, 1000, 1000);
  land = new Landscape(30, 2000, 2000);
  x = 0;
}

void draw() {

  // Ok, visualize the landscape space
  //background(255,213,0);
  pushMatrix();
  translate(width/2, height/2+20, -160);
  rotateX(PI/3);
  rotateZ(theta);
  belowWater.render();
  water.render();
  land.setColor(179, 119, 73,100);
  belowWater.setColor(51, 82, 251, 90);
  water.setColor(51, 90, 255, 70);
  land.render(); 
  popMatrix();
  
  water.calculate();
  belowWater.calculate();
  theta += 0.0025;
  x++;
  println(x);
  if(x%50 == 0){
    background(10, 200, 100);
  }
}

void mouseClicked(){
 water.disturb(); 
  
}
