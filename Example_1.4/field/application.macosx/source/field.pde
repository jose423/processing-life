/**
 * Title: Grass
 * Author: Maya Richman
 * Date: Februrary 3, 2013
 **/

//Original code
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-4: Vector multiplication
Grass[] field, field2, field3;

int locationx = 300;
void setup() {
  size(800, 700);
  smooth();
  int totalGrass = (int)random(20, 60); //pick a random number between 20 and 60
  field = new Grass[totalGrass]; //assign random number to arraysize
  for (int i=0;i<field.length;i++) { //create grass for each indice
    field[i] = new Grass(locationx, height/2); //place 10px apart (locationx)
    locationx +=10; //10 pixels apart
  }
}

void draw() {
  background(255, 255, 10); //yellow background
  translate(0, 200); //place field starting at indice 0,10
  for (int i=0;i < field.length;i++) { 
    field[i].draw(); //draw each grass in the array
  }
  for (int j=0;j<width/50;j++) { //for the width divided by 50 move right 50px
    translate(50, 0);
    for (int i=0;i < field.length;i++) { //for total grass in field
      if (mouseY > height/2) { //while mouseY is above the midway point
        field[i].increaseNoise(mouseY); //increase noise based on that value
      }
      else { //otherwise decrease noise
        field[i].decreaseNoise(mouseY);
      }
      field[i].draw(); //draw the grass with noise changed
    }
  }
}

