import ddf.minim.*;
import ddf.minim.analysis.*;

import processing.opengl.*;


Minim minim;
AudioPlayer jingle;
FFT fft;

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-2: Bouncing Ball, with PVector!
PVector location;
PVector velocity;

void setup() {
  size(500, 500, OPENGL);
  background(0);
  minim = new Minim(this);
  jingle = minim.loadFile("file://localhost/Users/mayarichman/Documents/music/Pak%20Duri's%20Room.aif", 2048);
  jingle.loop();
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
  fft.linAverages(128);
  location = new PVector(0, 0, -10);
  velocity = new PVector(2.5, 3, 2);
}

void draw() {
  background(0);
  translate(200, 200, 50);
  stroke(0, 120, 0);
  noFill();
  box(400);
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

