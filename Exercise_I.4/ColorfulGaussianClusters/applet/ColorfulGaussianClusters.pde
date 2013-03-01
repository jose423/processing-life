/**
* Title: MerMade in Spring
* Name: Maya Richman
* Date: January 19, 2013
* Assignment: 2-I.4
*
* Color chages dependent on xloc and yloc which give it a nice color blending effect
* The location changes randomly with a variable called location
*
**/

// Original Code: The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Import the Java Utilities library's Random class.
import java.util.Random;

// Declare a Random number generator object
Random generator;
float x = 1;
float y = 10;


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
  x++;
  y++;
  float sd = 10;   // Define a standard deviation
  float meanwidth = width/10;   // Define a mean value (diagonal of the screen along the x-axis)
  float meanheight = height/10; // Define a mean value (diagonal of the screen along the y-axis)
  xloc = ( xloc * sd ) + meanwidth;  // Scale the gaussian random number by standard deviation and mean
  yloc = ( yloc * sd ) + meanheight; // the same in this instance because the sketch is square
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



