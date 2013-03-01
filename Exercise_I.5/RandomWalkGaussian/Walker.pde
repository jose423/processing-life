/**
 * Title: Random Walk Gaussian 
 * Name: Maya Richman
 * Date: January 20, 2013
 * Assignment 2-I.5
**/

// The Nature of Code
// Original: Daniel Shiffman
// http://natureofcode.com

// A random walker class!

class Walker {
  Random generator;
  float x, y;
  
  Walker() {
    x = width/2;
    y = height/2;
    generator = new Random();
  }

 void display() {
  noStroke();
//     fill(200,100,123,10); 
//     fill(30,100,123,10);
  smooth();
  fill(x,y,255,100);  
  ellipse(x, y,40,40);
//  ellipse(width - x,height - y,40,40);
  
  }

  // Randomly move up, down, left, right, or stay in one place
  void walk() {
    float normalx = (float) generator.nextGaussian();
    float normaly = (float) generator.nextGaussian();
    float sd = 30;
    float meanx = 100;
    float meany = 200;
    float stepx = sd*normalx + meanx;
    float stepy = sd*normaly + meany; //both x and y have their own standard deviationa and step size
    x = stepx;
    y = stepy;
    // Stay on the screen
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
  }
}

