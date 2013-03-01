/**
* Title: Spring Left
* Name: Maya Richman
* Date: January 19, 2013
* Assignment: 2-I.4
**/
/**
Playing with color mixtures and foam brush style

**/

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Import the Java Utilities library's Random class.
import java.util.Random;

// Declare a Random number generator object
Random generator;

void setup() {
  size(500, 500);
  background(255);
  generator = new Random();   // Initialize generator
  smooth();
}

void draw() {

  // Get a gaussian random number w/ mean of 0 and standard deviation of 1.0
  float xloc = (float) generator.nextGaussian();
  float yloc = (float) generator.nextGaussian();
  
  float sd = 60;                // Define a standard deviation
  float meanwidth = width/5; //changing location on screen that they appear
  float meanheight = height/5;
  xloc = ( xloc * sd ) + meanwidth;  // Scale the gaussian random number by standard deviation and mean
  yloc = ( yloc * sd ) + meanheight;
  float location = random(500);
  noStroke();
  //fill(location, location, 255 - (xloc + yloc), 20);
  //noStroke();
  //draws an ellipse at each location with normal distribution, in time each color will have it's own "center"
  //ellipse(xloc + location, yloc + location, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  
  fill(50 - xloc, yloc, 10, 20); 
  ellipse(xloc,yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(200 - xloc, 200 + yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(100 - xloc, 200 + yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(400 + xloc, 100 + yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(300 + xloc, 100 + yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"

  //ellipse(xloc + location, yloc + location, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"

  
  fill(xloc, yloc, 255, 20);
  ellipse(500 - xloc, 500 - yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(200 + xloc, 200 - yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(100 + xloc, 100 - yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(400 + xloc, 100 - yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(100 - xloc, 200 + yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"
  ellipse(400 + xloc, 400 + yloc, random(16), random(16)); //changing the size of the ellipse at random to get more variation in shapes to make "less perfect"

}



