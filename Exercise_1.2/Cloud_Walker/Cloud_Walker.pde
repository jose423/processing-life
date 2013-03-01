/**
* Title: Walking Cloud (w/ Vectors)
* Name: Maya Richman
* Date: January 14, 2013
* Assignment 2- Chapter 1-2 Exercise
**/
// Original by:
// Daniel Shiffman
// http://natureofcode.com

// A random walker object!

Walker w;
int opacity = 100;

void setup() {
  size(500, 500);
  background(65, 129, 254); //changed to bright blue
  // Create a walker object
  w = new Walker();
}

public void draw() {
  // Run the walker object
  w.step();
  w.render();
}

void keyPressed() { //When the up arrow is pressed a green circle appears and enlarges increasing the step
  if (key == CODED) {
    if (keyCode == UP) {
      w.step=w.step+1;
      smooth();
      noStroke(); 
      fill(40, 450, 40, 50);
      ellipse(40, 450, w.step - 1, w.step - 1);
    }
    if (keyCode == DOWN) { //the down arrow makes a blue circle decrease and decreases the steps
      if (w.step != 0) {
        w.step=w.step-1;
      }
      fill(65, 129, 254); //changed to bright blue
      ellipse(40, 450, w.step, w.step);
    }
  }
}

