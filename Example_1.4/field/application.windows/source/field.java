import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class field extends PApplet {

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
public void setup() {
  size(800, 700);
  smooth();
  int totalGrass = (int)random(20, 60); //pick a random number between 20 and 60
  field = new Grass[totalGrass]; //assign random number to arraysize
  for (int i=0;i<field.length;i++) { //create grass for each indice
    field[i] = new Grass(locationx, height/2); //place 10px apart (locationx)
    locationx +=10; //10 pixels apart
  }
}

public void draw() {
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

/**
 * Title: Grass
 * Author: Maya Richman
 * Date: Februrary 3, 2013
 **/

class Grass {

  float noise2 = 0.1f; //starting point for noise
  PVector root, growth;
  //difference "center" based on constructor, same multiplying effect
  Grass(float x_, float y_) {
    growth = new PVector(600, 350);
    root = new PVector(x_, y_);
  }

  public void draw() {

    PVector growth = new PVector(mouseX, mouseY);
    growth.sub(root);//subtract from root depending on each grass object made
    growth.mult(1.3f); //static for now

    strokeWeight(1);
    stroke(10, random(200*noise(90), 200*noise(mouseY)), 0);
    line(0, 0, growth.x, growth.y); //draw remainder between subtraction from each root plus 1.3 times the length
  }
  //increases/decreases noise dependent on location of mouse
  public void increaseNoise(float mouse) { 
    noise2 = (0.01f)*abs(mouse - height);
    noiseDetail(20, noise2);
  }
  public void decreaseNoise(float mouse) {
    noise2 = (0.01f)*(mouse - height);
    noiseDetail(20, noise2);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "field" });
  }
}
