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

public class RightRandomWalk extends PApplet {

/**
* Title: Son Set
* Name: Maya Richman
* Date: January 20, 2013
* Assignment 2-Ex. I.1
**/
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;

public void setup() {
  size(400,400);
  frameRate(30);
  // Create a walker object
  w = new Walker();

}

public void draw() {
  background(255);
  // Run the walker object
  w.walk();
  w.draw();
}



/**
* Title: Son Set
* Name: Maya Richman
* Date: January 20, 2013
* Assignment 2-Ex. I.1
**/
//Walker that moves to the right and down

//Original Code:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Walker {
  float x, y;

  Walker() {
    x = 0;
    y = 0;
  }

  public void draw() {
    //change color dependent on x and y
    fill(y + 34, y - 54, 255 - y, 100);
    rect(x,y, 16, 16);   // Draw a rectangle
  }

  // Randomly move up, down, left, right, or stay in one place
  public void walk() {
    float vx, vy;
    //40% of the time jump 10
    if (random(1) < 0.4f) {
      vx = random(-10, 10);
      vy = random(-10, 10);
    } //60% of the time jump 2, and move down and to the right
    else {  
      vx = random(0, 10);
      vy = random(0, 10);
    }  
    x += vx;
    y += vy;

    // Stay on the screen
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "RightRandomWalk" });
  }
}
