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

public class EraserHead_Walker extends PApplet {

/**
* Title: Eraserhead
* Name: Maya Richman
* Date: January 20, 2013
* Assignment 2-Ex. I.3
**/

//Original Code:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;

public void setup() {
  size(400, 400);
  frameRate(30);
  background(235,0,90);
  // Create a walker object
  w = new Walker();
}

public void draw() {
  smooth();
  // Run the walker object
  w.walk();
  w.draw();
}

public void keyPressed() {
  if (key == CODED) { //left arrow decreases probability that walker will follow mouse, right increases
    if (keyCode == RIGHT) {
      if (w.prob < 1.0f) {
        w.prob = w.prob + 0.1f;       
        w.prob = (float)((int)(w.prob*10))/10;
      }
    }
    if (keyCode == LEFT) { 
      if (w.prob > 0.0f) {
        w.prob = w.prob - 0.1f;
      }
    }
  }
}

class Gauge {
  float colorprob;
  
  Gauge(float prob) {
    //rectangle with 10 circles in it
    colorprob = prob;
  }

  public void draw() {
    smooth();
    fill(248,214,224,20);
    rect(10, 10, 100, 10);
    int i = 15;
    for (int c = 0; c < (colorprob*10); c++) {
      smooth(); //show red dot for every increase in probability to follow mouse
      fill(106, 17, 42);
      ellipse(i, 15, 6, 6);
      i = i + 10;
    }
  }
}

// Tweak: Maya Richman

// The Nature of Code
// Original: Daniel Shiffman
// http://natureofcode.com

// A random walker class!

class Walker {
  float x, y;
  float prob, vx, vy;
  Gauge g;

  Walker() {
    x = width/2;
    y = height/2;
    prob = 0.1f;
  }

  public void draw() {
    noStroke();
    fill(255, 20);
    ellipse(x, y, 30, 30);   // Draw an ellipse at our "normal" random location
  }

  public void walk() {
    g = new Gauge(prob); //construct new gauge with new probability
    g.draw();
    float randomNumber = (float)random(1);
    if (randomNumber < prob) {
      if (mouseY < 250 && mouseX < 250) {  //move to corners based off of the X and Y of the mouse    
        vx--;
        vy--;
      }
      else if (mouseY <= 250 && mouseX >= 250) {
        vy--;
        vx++;
      }
      else if (mouseY >= 250 && mouseX >= 250) {  
        vy++;
        vx++;
      } 
      else if (mouseY >= 250 && mouseX <= 250) {  
        vx--;
        vy++;
      }
    }
    else { //if random number is greater than the prob, randomly move 
      vx = random(-5, 5);
      vy = random(-5, 5);
    }
    x += vx;
    y += vy;

    // Stay on the screen
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "EraserHead_Walker" });
  }
}
