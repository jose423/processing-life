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

void setup() {
  size(500, 500);
  randomCounts = new float[30];
}

void draw() {
  background(255);
  int prob = int(random(255));
  // Pick a random number and increase the count
  int index = int(random(randomCounts.length));
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

