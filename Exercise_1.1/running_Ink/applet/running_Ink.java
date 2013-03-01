import processing.core.*; 
import processing.xml.*; 

import processing.pdf.*; 

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

public class running_Ink extends PApplet {

Inkblot friend;
int clicked = 0;

public void setup() {
  size(600, 600);
  background(255);
  smooth();
  friend = new Inkblot();
}

public void draw(){
   friend.draw(); 
}

public void mouseDragged() {
  strokeWeight(4);
  line(friend.blot.x,friend.blot.y,friend.blot.x,friend.blot.y);
  line((600-friend.blot.x),friend.blot.y,(600-friend.blot.x),friend.blot.y);
}

public void mouseClicked() {

//the line below allows every image to be saved once clicked
//saveFrame("rosarch-####.tif"); 
  background(255-clicked,255-(clicked)*(clicked),clicked,.9f);
  
  clicked++;
  
  if(clicked > 1){ 
    background(255-(clicked)*(clicked),255-random(255),255-random(255),9);
  }
   if(clicked%5 == 0){
    PImage b;
    b = loadImage("copy-left-right-center.png");
    image(b, 0, 0);
    filter(BLUR);
    friend.colorize = true;
  }else if(clicked%6 == 0){
    PImage b;
    String url = "Frost.png";
    b = loadImage(url, "png");
    image(b, 0, 0,600,600);
    filter(INVERT);
    friend.colorize = true;
  }else if(clicked%7 == 0){
    PImage b;
    String url = "rosarch-0580.tif";
    b = loadImage(url);
    image(b, 0, 0,600,600);
    filter(INVERT);
    friend.colorize = true;
  }
  else{
   friend.colorize = false;
  }
 }
 
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/39662*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */



class Inkblot {

  PVector blot = new PVector(0, 0);
  boolean colorize;

  Inkblot() {
    blot.x = mouseX;
    blot.y = mouseY;
    colorize = false;
  }

  public void draw() {

    strokeWeight(random(15)*random(5));
    blot.x = mouseX;
    blot.y = mouseY;

    if (!colorize) {
      stroke(0, random(90, 100));
      point(blot.x, blot.y);
      point((600-blot.x), blot.y);
    }
    else {
      stroke(random(255), random(255), random(255));
      point(blot.x, blot.y);
      point((600-mouseX), mouseY);
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "running_Ink" });
  }
}
