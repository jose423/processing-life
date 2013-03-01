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

public class Noise2D extends PApplet {

/**
 * Title: Ahh
 * Author: Maya Richman
 **/
//Original
// Daniel Shiffman
// The Nature of Code
// http://natureofcode.com

//running on the sidewalk really fast

Noise noise1, noise2;
Divider d1,d2,d3;
float center = 400;

public void setup() {
  size(800, 400);
  noise1 = new Noise(0.1f, 5, 0.2f, 0.0f, 0.0f);
  noise2 = new Noise(0.9f, 1, 0.8f, 0.2f, 0.1f);
  d1 = new Divider(center,50,0,5.2f);
  d2 = new Divider(center,200,0,5.2f);
  d3 = new Divider(center,225,1.0f,5.2f);
}

public void draw() {
  noise1.draw();
  noise2.draw();
  d1.draw();
  d2.draw();
  d3.draw();
}

class Divider {
  PVector location, speed;
  int dwidth = 10;
  int dheight = 100;

  Divider(float x_, float y_, float xspeed, float yspeed) {
    location = new PVector(x_, y_);
    speed = new PVector(xspeed, yspeed);
  }

  public void draw() {
    fill(235, 245, 47); 
    noStroke();
    rect(location.x, location.y, dwidth, dheight);
    run();
  }

  //make method that moves yellow rectange PVector
  public void run() {

    location.add(speed);

//    if (location.x > width - dwidth/2 || (location.x < 0)) {
//      location.x = 1;
//    }
    if ((location.y > height - dheight/2) || (location.y < 0)) {
      location.y = -dwidth/2;
    }
  }
}

class Noise {

  float increment;
  int noiseDetailVar1;
  float noiseDetailVar2;//0.45;
  float zoff;
  float xoff;
  Divider d1, d2, d3, d4;
  float center = 400;

  Noise(float i_, int o_, float fallout_, float z_, float x_ ) {
    increment = i_;//0.1;
    noiseDetailVar1 = o_;//3;
    noiseDetailVar2 = fallout_;//0.20;
    zoff = z_;//0.0;
    xoff = x_;//0.0;
  } 

  public void draw() {
    background(255);
    loadPixels();

    // Start xoff at 0

    // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
    for (int x = 0; x < width; x++) {
      float yoff = 0.0f;   // For every xoff, start yoff at 0
      for (int y = 0; y < height; y++) {
        yoff += 0.01f; // Increment yoff

        // Calculate noise and scale by 255
        noiseDetail(noiseDetailVar1, noiseDetailVar2);

        float R = map(noise(xoff, yoff, zoff), 0, 1, 0, 255); //
        float G = map(noise(xoff+600, yoff+900, zoff), 0, 1, 0, 255); //add some offset to xoff and yoff so that R, G and B are not equal
        float B = map(noise(xoff+200, yoff+50, zoff), 0, 1, 0, 255); // add some offset to xoff and yoff so that R, G and B are not equal


        // Try using this line instead
        //float bright = random(0,255);

        // Set each pixel onscreen to a grayscale value
        pixels[x+y*width] = color(G, 255);
      }
      xoff += 0.2f;   // Increment xoff
    }

    updatePixels();

    zoff = zoff - 0.3f;
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Noise2D" });
  }
}
