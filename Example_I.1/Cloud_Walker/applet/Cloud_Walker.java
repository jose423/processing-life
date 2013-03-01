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

public class Cloud_Walker extends PApplet {

/**
* Title: Walking Cloud
* Name: Maya Richman
* Date: January 14, 2013
* Assignment 1-a
**/

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;
int opacity = 100;

public void setup() {
  size(500,500);
  background(65,129,254); //changed to bright blue
  // Create a walker object
  w = new Walker();
}

public void draw() {
    // Run the walker object
  w.step();
  w.render();
 }


/**
* Title: Walking Cloud
* Name: Maya Richman
* Date: January 14, 2013
* Assignment 1-a
**/

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker object!

class Walker {
  int x,y;

  Walker() {
    x = width/2;
    y = height/2;
  }

  public void render() {
    stroke(255);
    point(x,y);
  }

  // Randomly move up, down, left, right, or stay in one place
  public void step() {
    int choice = PApplet.parseInt(random(4));
    //randomly decrement or increment x or y
    if (choice == 0) {
      x++;
    } else if (choice == 1) {
      x--;
    } else if (choice == 2) {
      y++;
    } else {
      y--;
    }

   float prob = random(1);
   //each option is as likely and takes 4 steps more than the original
   if(prob < .25f){
     x=x+5;
   }
   if(prob >= .25f && prob < .50f){
     x=x-5; 
   }
   if(prob >= .50f && prob < .75f){
     y=y+5; 
   }
   if(prob >= .75f && prob < 1){
     y=y-5; 
   }
   
    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
    
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Cloud_Walker" });
  }
}
