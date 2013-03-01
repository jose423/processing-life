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
import java.util.Random;

// Declare a Random number generator object
Random generator;
float xoff = 0.0;
float yoff = 1.0;
float increment = 0.1;
int i = 10;
void setup() {
  size(500, 500);
  background(139,178,198);
  smooth();
}
void draw() {
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

