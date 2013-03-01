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

public class Balloon_Main extends PApplet {

//Using forces, simulate a helium-filled balloon floating upward and bouncing off the top of a window. 
//Can you add a wind force that changes over time, perhaps according to Perlin noise?
Balloon hell;
PVector wind, gravity;
float xoff = 0.0f;

ArrayList<Balloon> helloBalloons = new ArrayList<Balloon>();
public void setup() {
  size(1000, 500);
  background(0);
  //  hell = new Balloon(width/2);
  //make wind change over time in draw
  wind = new PVector(0.01f, 0);
  gravity = new PVector(0, -0.2f);
}

public void draw() {
  background(0);

  //update one balloon
  //  hell.update();
  //  hell.display();
  //  hell.applyForce(gravity);
  //  windChanges();
  //  hell.applyForce(wind);
  windChanges();
  //update all balloons in arraylist
  for (Balloon balloon: helloBalloons) {
    balloon.update();
    if (balloon.checkEdges()) {
      helloBalloons.remove(balloon);
      break;
    }
    balloon.display();
    balloon.applyForce(gravity);
    balloon.applyForce(wind);
  }
}
//when mouse is clicked make new Balloon object and add to arraylist helloBalloons
public void mouseClicked() {
  helloBalloons.add(new Balloon(mouseX));
}
public void mouseDragged() {
  //right now wind depends on clicks, but should eventually depend on perlin noise
  //  wind.mult(0);
}

public void windChanges() {
  float windChange = noise(xoff);
  xoff = xoff + 0.01f;
  wind.set(windChange*0.09f, 0.0f, 0.0f);
}

//Using forces, simulate a helium-filled balloon floating upward and bouncing off the top of a window. 
//Can you add a wind force that changes over time, perhaps according to Perlin noise?
class Balloon {

  PVector location, velocity, acceleration;  

  Balloon(float _x) {
    location = new PVector(_x, height);
    velocity = new PVector(0, -0.05f);
    acceleration = new PVector(0, 0);
  }

  public void display() {
    fill(245, 0, 0, 90);
    smooth();
    noStroke();
    ellipse(location.x, location.y, 50, 55);
    fill(255);
    triangle(location.x - 20,location.y,location.x,location.y,location.x + 20,location.y);    
  }
  public void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  public void applyForce(PVector force) {
    acceleration.add(force);
  }

  //when balloon hits the top of the sketch where x <= 0, have bounce back, otherwise if balloon leaves screen delete from the arraylist of balloons
  public boolean checkEdges() {
    if (location.y <= 0) {
      velocity.y *= -0.7f;
      location.y = 0;
      return false;
    }    
    if (location.x >= width || location.x <= 0) {
      return true;
    }
    return false;
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Balloon_Main" });
  }
}
