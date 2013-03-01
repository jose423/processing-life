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

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover mover;
float max;
float up;

public void setup() {
  size(800, 200);
  mover = new Mover();
  up = 100;
}

public void draw() {
  background(0);

  mover.update();
  mover.checkEdges();
  mover.display();
}

public void keyPressed() {
  max = mover.getMax();
  if (key == CODED) {
    if (keyCode == UP) {
      if(up < width){
      max++;
      fill(0);
      ellipse(up, 150, 20, 20);
      up = up + 20;
      mover.setMax(max);
      println(max);
      }
    }
    if (keyCode == DOWN) {
      if (up > 0) {
        max--;
        ellipse(up, 150, 20, 20);
        up = up - 20;
        mover.setMax(max);
        println(max);
      }
    }
  }
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
    location = new PVector(random(width/2), random(height/2));
    velocity = new PVector(random(0, 5), random(1, 8));
    acceleration = new PVector(-0.001f, 0.01f);
    max = 1;
  }

  public void update() {
    velocity.add(acceleration);
//    velocity.limit(max);
    location.add(velocity);
  }

  public void display() {
    smooth();
    stroke(255);
    strokeWeight(2);
    fill(127, 500, 30);
    ellipse(location.x, location.y, ballSize, ballSize);
  }
  public void speedUp() {
    velocity.x = velocity.x*2; 
    velocity.y = velocity.y*2;
  }
  public void setMax(float maxAccerlation) {
    max = maxAccerlation;
  }
  public float getMax() {
    return max;
  }

  //  void limit(PVector vector, float max) {
  //    if (vector.mag() > max) {
  //      vector.normalize();
  //      vector.mult(max);
  //    }
  //  }

  public void checkEdges() {

    if (location.x > width) {
      location.x = 0;
      //      speedUp();
      ballSize=ballSize-5;
    } 
    else if (location.x < 0) {
      location.x = width;
      ballSize=ballSize-5;
    }

    if (location.y > height) {
      location.y = 0;
      ballSize=ballSize-5;
    } 
    else if (location.y < 0) {
      location.y = height;
//      ballSize=ballSize-5;
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "abstract_tennis_ball" });
  }
}
