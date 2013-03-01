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

public void setup() {
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

public void keyPressed() { //When the up arrow is pressed a green circle appears and enlarges increasing the step
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


class Walker {
  PVector location;
  int step; //can this be part of a new pvector class


  Walker() {
    location = new PVector(width/2,height/2);
    step = 5;
  }

  public void render() {
    stroke(255);
    point(location.x,location.y);
  }

  // Randomly move up, down, left, right, or stay in one place
  public void step() {
    int choice = PApplet.parseInt(random(4));
    //randomly decrement or increment x or y
    if (choice == 0) {
      location.x++;
    } else if (choice == 1) {
      location.x--;
    } else if (choice == 2) {
      location.y++;
    } else {
      location.y--;
    }

   float prob = random(1);
   //each option is as likely and takes 4 steps more than the original
   if(prob < .25f){
     location.x=location.x+step;
   }
   if(prob >= .25f && prob < .50f){
     location.x=location.x-step; 
   }
   if(prob >= .50f && prob < .75f){
     location.y=location.y+step; 
   }
   if(prob >= .75f && prob < 1){
     location.y=location.y-step; 
   }
   
    location.x = constrain(location.x,0,width-1);
    location.y = constrain(location.y,0,height-1);
    
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Cloud_Walker" });
  }
}
