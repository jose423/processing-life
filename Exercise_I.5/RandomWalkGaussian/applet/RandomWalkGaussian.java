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

public class RandomWalkGaussian extends PApplet {

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;

public void setup() {
  size(400,400);
  frameRate(5);
  // Create a walker object
  w = new Walker();

}

public void draw() {
  background(0);
  // Run the walker object
  w.walk();
  w.display();
}



/**
 * Title: Random Walk Gaussian 
 * Name: Maya Richman
 * Date: January 20, 2013
 * Assignment 2-I.5
**/

// The Nature of Code
// Original: Daniel Shiffman
// http://natureofcode.com

// A random walker class!

class Walker {
  Random generator;
  float x, y;
  
  Walker() {
    x = width/2;
    y = height/2;
    generator = new Random();
  }

 public void display() {
  noStroke();
//     fill(200,100,123,10); 
//     fill(30,100,123,10);
  smooth();
  fill(x,y,255,100);  
  ellipse(x, y,40,40);
//  ellipse(width - x,height - y,40,40);
  
  }

  // Randomly move up, down, left, right, or stay in one place
  public void walk() {
    float normalx = (float) generator.nextGaussian();
    float normaly = (float) generator.nextGaussian();
    float sd = 30;
    float meanx = 100;
    float meany = 200;
    float stepx = sd*normalx + meanx;
    float stepy = sd*normaly + meany; //both x and y have their own standard deviationa and step size
    x = stepx;
    y = stepy;
    // Stay on the screen
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "RandomWalkGaussian" });
  }
}
