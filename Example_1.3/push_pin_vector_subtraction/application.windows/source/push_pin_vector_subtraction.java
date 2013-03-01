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

public class push_pin_vector_subtraction extends PApplet {

/**
* Title: Pin Head
* Author: Maya Richman
* Date: January 25, 2013
**/

//Original Code
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-3: Vector subtraction

public void setup() {
  size(800,200);
  smooth();
}

public void draw() {
  background(230);
  
  PVector mouse = new PVector(mouseX,mouseY); //create a PVector in an infinite loop that follows the mouse location
  PVector center = new PVector(width/2,height/2); //create center pVector which doesn't change
  mouse.sub(center); //subtract the distance from the center from the mouse showing the distance of the mouse to the center
  
  translate(width/2,height/2); //place in center of sketch
  fill(255,50,80,80);
  ellipse(0,0,mouse.x + 30,mouse.x + 30); //create an ellipse always 30pixels greater than the mouse x location to get circle effect
  strokeWeight(2);
  stroke(0);
  line(0,0,mouse.x,mouse.y); //draw line at mouse x, y  
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "push_pin_vector_subtraction" });
  }
}
