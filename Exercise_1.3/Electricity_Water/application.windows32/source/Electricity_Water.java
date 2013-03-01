import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 
import processing.opengl.*; 

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

public class Electricity_Water extends PApplet {







Minim minim;
AudioPlayer jingle;
FFT fft;

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-2: Bouncing Ball, with PVector!
PVector location;
PVector velocity;

public void setup() {
  size(500, 500, OPENGL);
  background(0);
  minim = new Minim(this);
  jingle = minim.loadFile("file://localhost/Users/mayarichman/Documents/music/Pak%20Duri's%20Room.aif", 2048);
  jingle.loop();
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
  fft.linAverages(128);
  location = new PVector(0, 0, -10);
  velocity = new PVector(2.5f, 3, 2);
}

public void draw() {
  background(0);
  translate(200, 200, 50);
  stroke(0, 120, 0);
  noFill();
  box(200);
  noStroke();
  fill(255, 10);
  println("location x" + location.x);
  println("location y" + location.y);
  println("location z" + location.z);

  // Add the current speed to the location.
  location.add(velocity);
  fft.forward(jingle.mix);
  if ((location.x > 70) || (location.x < -80)) {
    velocity.x = velocity.x * -1;
  }
  if ((location.y > 70) || (location.y < -80)) {
    velocity.y = velocity.y * -1;
  }
  if ((location.z > 0) || (location.z < -100)) {
    velocity.z = velocity.z * -1;
  }
  
  //dependent on averages from song, change color
  fill((int)fft.getAvg(1)*10, 10, (int)fft.getAvg(1)*4);

  // Display circle at x location
  stroke(0, 139, 29);
  translate(location.x, location.y,location.z);
  sphereDetail(6, 18);
  lights();
  sphere(40);
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Electricity_Water" });
  }
}
