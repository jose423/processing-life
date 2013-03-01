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

public class abstract_tennis_ball extends PApplet {

/**
 * Author: Maya Richman
 * Title: Abstract Tennis ball
 * Date: January 25, 2013
 **/
//Original Code
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover mover;

public void setup() {
  size(800,200);
  mover = new Mover(); 
}

public void draw() {
//  background(0);
  
  mover.update();
  mover.checkEdges();
  mover.display();
}

/**
 * Author: Maya Richman
 * Title: Abstract Tennis ball
 * Date: January 25, 2013
 **/

/**
 *This sketch changes the size of the mover everytime it exceeds the height or width of the sketch
 *
 *Possible edit later: make it look like it is bouncing up and down with changing size and location and speed combined
 **/

//Original Code by
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  int ballSize = 48;
  float max;

  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-1, 5), random(-2, 2));
    acceleration = new PVector(-0.001f, 0.01f);
    max = 10;
  }

  public void update() {
    velocity.add(acceleration);
    velocity.limit(max);
    location.add(velocity);
  }

  public void display() {
    smooth();
    stroke(255);
    strokeWeight(1);
    fill(127, 500, 30, 20);
    ellipse(location.x, location.y, ballSize, ballSize);
  }
  public void speedUp() {
    velocity.x = velocity.x*2; 
    velocity.y = velocity.y*2;
  }

  public void limit(PVector vector, float max) {
    if (vector.mag() > 10) {
      vector.normalize();
      vector.mult(max);
    }
  }

  public void checkEdges() {

    if (location.x > width) {
      location.x = 0;
      speedUp();
      ballSize=abs(ballSize-5);
    } 
    else if (location.x < 0) {
      location.x = width;
      ballSize=abs(ballSize-1);
    }

    if (location.y > height) {
      location.y = 0;
      ballSize=abs(ballSize-5);
      println(ballSize);
    } 
    else if (location.y < 0) {
      location.y = height;
      ballSize=abs(ballSize+1);
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "abstract_tennis_ball" });
  }
}
