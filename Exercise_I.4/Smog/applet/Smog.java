import processing.core.*; 
import processing.xml.*; 

import java.util.Random; 

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

public class Smog extends PApplet {

/**
 * Title: {Smog}
 * Name: Maya Richman
 * Date: January 19, 2013
 * Assignment: 2-I.4c
 *
 *Using Perlin Noise to make smog and city forms below
 **/

// Original Code: The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Import the Java Utilities library's Random class.


// Declare a Random number generator object
Random generator;
float xoff = 0.0f;
float yoff = 1.0f;
float increment = 0.1f;
int i = 10;
public void setup() {
  size(500, 500);
  background(139,178,198);
  smooth();
}
public void draw() {
  float n = noise(xoff)*width;
  float m = noise(yoff)*height;
  xoff += increment; 
  yoff += increment;
  noStroke();
  fill(0,10);
  float circleSize = random(100);
  ellipse(n, m, circleSize, circleSize);
  fill(10,90);
  rect(0 + random(width),height-random(10),random(40),random(100));
  i=i-10;
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Smog" });
  }
}
