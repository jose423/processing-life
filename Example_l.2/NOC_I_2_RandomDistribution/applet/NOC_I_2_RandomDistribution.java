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

public class NOC_I_2_RandomDistribution extends PApplet {

/**
 * Title: Easter Distro
 * Name: Maya Richman
 * Date: January 14, 2013
 * Assignment 1-b
 **/

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An array to keep track of how often random numbers are picked
float[] randomCounts;

public void setup() {
  size(500, 500);
  randomCounts = new float[30];
}

public void draw() {
  background(255);
  int prob = PApplet.parseInt(random(255));
  // Pick a random number and increase the count
  int index = PApplet.parseInt(random(randomCounts.length));
  randomCounts[index]++;

  // Draw a rectangle to graph results
  stroke(0);
  strokeWeight(1);

  int w = width/randomCounts.length;

  for (int x = 0; x < randomCounts.length; x++) {
    rect(x*w,width - randomCounts[x], w-1, randomCounts[x]);

    fill(random(255), random(255), random(255), 90); //fills each rectangle with a different random color each time a value is added
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "NOC_I_2_RandomDistribution" });
  }
}
