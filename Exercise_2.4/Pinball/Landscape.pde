/**
 * Author: Maya Richman
 * Date: March 1, 2013
 * Title: Pinball Wizard Movers
 * Original Code from Daniel Shiffman
 **/
/**
 *
 * Exercise 2.4
 * Create pockets of friction in a
 * Processing sketch so that objects only experience
 * friction when crossing over those pockets. What if
 * you vary the strength (friction coefficient) of each area?
 * What if you make some pockets feature the opposite of
 * friction—i.e., when you enter a given pocket you
 * actually speed up instead of slowing down?
 *
 * friction will be standard, but a check boundaries method,
 * applied to the landscape it falls upon,
 * will apply that landscape particular friction
 *
 **/
import processing.opengl.*;

class Landscape {

  float x, y, w, h;
  PVector l;
  float c;
  float xoff = 0.1;
  PVector location; 
  boolean isBumped;

  //construct landscape with particular size, location and friction value
  Landscape(float _x, float _y, float _w, float _h, float _c) {
    location = new PVector(_x, _y);  
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    isBumped = false;
  }
  //change color if mover has hit landscape
  void  touched() { 
    noStroke();
    fill(0, random(200) + (noise(xoff)*255)%255, random(200) + (noise(xoff)*255)%255);
    rect(x, y, w, h);
    xoff++;
  } 
  //display landscape
  void display() {
    noStroke();
    fill((random(200) + (noise(xoff)*255))%255, (random(200) + (noise(xoff)*255))%255, 0);
    rect(x, y, w, h);
    xoff++;
  }
  //does landscape contain a particular mover?
  boolean contains(Mover m) {
    l = m.location;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      isBumped = true;
      return true;
    }  
    else {
      return false;
    }
  }
  //returns whether landscape has been bumped
  boolean bumped() {
    return isBumped;
  }
}

