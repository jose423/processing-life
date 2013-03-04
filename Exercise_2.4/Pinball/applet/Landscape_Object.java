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

public class Landscape_Object extends PApplet {

/**
 *
 * Exercise 2.4
 * Create pockets of friction in a
 * Processing sketch so that objects only experience
 * friction when crossing over those pockets. What if
 * you vary the strength (friction coefficient) of each area?
 * What if you make some pockets feature the opposite of
 * friction\u2014i.e., when you enter a given pocket you
 * actually speed up instead of slowing down?
 *
 **/

/**
 
 friction will be standard, but a check boundaries method,
 applied to the landscape it falls upon,
 will apply that landscape particular friction
 
 **/

class Landscape {

  float x, y, w, h;
  PVector l;
  float c;
  float xoff = 0.1f;
  PVector location; 
  boolean isBumped;

  Landscape(float _x, float _y, float _w, float _h, float _c) {
    location = new PVector(_x, _y);  
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    isBumped = false;
  }
  public void  update(){
    noStroke();
    fill(0, random(200) + (noise(xoff)*255)%255, random(200) + (noise(xoff)*255)%255);
    rect(x, y, w, h);
    xoff++;   
  } 
  public void display() {
    noStroke();
    fill((random(200) + (noise(xoff)*255))%255, (random(200) + (noise(xoff)*255))%255, 0);
    rect(x, y, w, h);
    xoff++;
  }
  public boolean contains(Mover m) {
    l = m.location;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      isBumped = true;
      return true;
    }  
    else {
      return false;
    }
  }

  public boolean bumped() {
    return isBumped;
  }
}

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;

  Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  public void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  public void display() {
    stroke(0);
    strokeWeight(2);
    fill(255, 127);
    ellipse(location.x, location.y, mass*16, mass*16);
    smooth();
  }

  public boolean checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
      return false;
    } 
    else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;      
      return false;
    }
    if (location.y > height) {
      velocity.y *= -1;
      return true;
    }
    return false;
  }
}

/*
remove movers from arraylist after they hit the bottom
 upon click make new set of however many mover to drop
 */




// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

ArrayList<Mover> movers = new ArrayList<Mover>();
ArrayList<Landscape> landscapes = new ArrayList<Landscape>();
List<Landscape> landscapesSync = Collections.synchronizedList(landscapes);
float c = 0.2f;
int i = 1;
int n = 0;
float frictionIncrease = 0.1f;
int totalMovers = 40;

public void setup() {
  size(600, 700);
  randomSeed(1);
  for (int i=0;i<totalMovers;i++) {
    movers.add(new Mover(random(1, 4), random(width), 0));
  }
  for (int i=0;i<20;i++) {

    //could make landscape objects long lines of conjoined squares instead of initializing them this way
    landscapesSync.add(new Landscape(0+n, 70+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 100+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 130+n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(0+n, 200+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 230+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 260+n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(70+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(100+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(130+n, 0+n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(200+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(230+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(260+n, 0+n, 10, 10, frictionIncrease));

    //--------------------------------------------------------------------

    landscapesSync.add(new Landscape(width-n, height-70-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-100-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-130-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-n, height-200-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-230-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-260-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-70-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-100-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-130-n, height-0-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-200-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-230-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-260-n, height-0-n, 10, 10, frictionIncrease));




    n += 10;
    frictionIncrease++;
  }
}

public void draw() {
  background(0);

  //  cycle through landscapesSync and display
  for (Landscape landscape : landscapesSync) {
    landscape.display();
    if (landscape.bumped()) {
      landscape.update();
    }
  }

  for (Mover mover : movers) {
    PVector wind = new PVector(0.01f, 0);
    PVector gravity = new PVector(0, 0.1f*mover.mass);

    c = 0.05f;

    //does landscape contain mover?
    for (Landscape landscape : landscapesSync) {
      if (landscape != null) {
        if (landscape.contains(mover)) { //contains checks the boundaries that the landscape has
          c = landscape.c;
          landscape.update(); //turn blue if landscape contains mover
        }
      }
    }

    PVector friction = mover.velocity.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);

    mover.applyForce(friction);
    mover.applyForce(wind);
    mover.applyForce(gravity);

    mover.update();
    mover.display();
    if (mover.checkEdges()) {
      movers.remove(mover);
      break;
    }
  }
}
public void mouseClicked() {
  for (int i=0;i<totalMovers;i++) {
    movers.add(new Mover(random(1, 4), random(width), 0));
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Landscape_Object" });
  }
}
