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

public class ColorfulGaussianClustersDifferentMethod extends PApplet {

/**
* Title: MerMade in Spring
* Name: Maya Richman
* Date: January 19, 2013
* Assignment: 2-I.4 c
*
* Color changes dependent on xloc and yloc which give it a nice color blending effect
* The location changes randomly with a variable called location
* Based off of the ColorfulGaussianClusters sketch, but turned out very different looking
*
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

public void setup() {
  size(500, 500);
  background(255);
  generator = new Random();   // Initialize generator
  smooth();
}

public void draw() {

  // Get a gaussian random number w/ mean of 0 and standard deviation of 1.0
  float xloc = noise(xoff)*width;
  float yloc = noise(yoff)*height;
  xoff+=increment;
  yoff+=increment;
  float location = random(500); // a random number between 0 and 500
  noStroke();
  fill(255 - (255 - location), 255 - location, 255 - (xloc + yloc), 10); //fill each ellipse based off the variable location to change 
  fill(255 - (255 - location), 255 - location, 255 - (xloc + yloc), 10); //fill each ellipse based off the variable location to change 
  noStroke();
  
  /* using the same random location variable, every line becomes 
    clustered with the same normal distribution, if location were 
    not added there would be one small cluster with a brighter color,
    but because the location will change each time, the concentration of color can occur at any location that is frequented multiple times, the fuzziness around the lines shows the standard deviation
   around each line with the mean being the brightest. I am also experimenting with crossing lines here and the colors that form.
 */
  ellipse(xloc + location, yloc + location, random(16), random(16));
  ellipse(500 - (xloc + location), (yloc + location), random(16), random(16));
  ellipse(250 - (xloc + location), yloc + location, random(16), random(16));
  ellipse(250 - (xloc + location), 500 - (yloc + location), random(16), random(16));
  ellipse(500 - (xloc + location), 250 - (yloc + location),random(16), random(16));  
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "ColorfulGaussianClustersDifferentMethod" });
  }
}
