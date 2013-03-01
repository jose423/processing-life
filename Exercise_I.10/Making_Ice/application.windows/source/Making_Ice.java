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

public class Making_Ice extends PApplet {

/**
 * Author: Maya Richman
 * Title: Making Ice
 * Date: January 28, 2013
 **/
//Original from The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Landscape with height values according to Perlin noise

Landscape land, water, belowWater;    
float theta = 0.0f;
int x;

public void setup() {
  background(10, 200, 100);
  size(800, 200, P3D);
  // Create a landscape object
  water = new Landscape(40, 1000, 1000);
  belowWater = new Landscape(40, 1000, 1000);
  land = new Landscape(30, 2000, 2000);
  x = 0;
}

public void draw() {

  // Ok, visualize the landscape space
  //background(255,213,0);
  pushMatrix();
  translate(width/2, height/2+20, -160);
  rotateX(PI/3);
  rotateZ(theta);
  belowWater.render();
  water.render();
  land.setColor(179, 119, 73,100);
  belowWater.setColor(51, 82, 251, 90);
  water.setColor(51, 90, 255, 70);
  land.render(); 
  popMatrix();
  
  water.calculate();
  belowWater.calculate();
  theta += 0.0025f;
  x++;
  println(x);
  if(x%50 == 0){
    background(10, 200, 100);
  }
}

public void mouseClicked(){
 water.disturb(); 
  
}
/**
 * Author: Maya Richman
 * Title: Beach 
 * Date: January 28, 2013
 **/
//Original Code from
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// "Landscape" example

class Landscape {

  int scl;           // size of each cell
  int w, h;           // width and height of thingie
  int rows, cols;    // number of rows and columns
  float zoff = 0.0f;  // perlin noise argument
  float[][] z;       // using an array to store all the height values 
  float r,g,b,a;
  float disturbLevel = 0.01f;
  
  Landscape(int scl_, int w_, int h_) {
    scl = scl_;
    w = w_;
    h = h_;
    cols = w/scl;
    rows = h/scl;
    z = new float[cols][rows];
    r = 0; 
    g = 0;
    b = 0;
    a = 100;
  }


  // Calculate height values (based off a neural netork)
  public void calculate() {
    float xoff = 0;
    for (int i = 0; i < cols; i++)
    { 
      float yoff = 3;
      for (int j = 0; j < rows; j++)
      {
        z[i][j] = map(noise(xoff, yoff,zoff), 0, 1, -120, 120);
        yoff += 0.1f;
      }
      xoff += 0.1f;
    }
    zoff+=disturbLevel;
  }

  // Render landscape as grid of quads
  public void render() {
    // Every cell is an individual quad
    // (could use quad_strip here, but produces funny results, investigate this)
    for (int x = 0; x < z.length-1; x++)
    {
      for (int y = 0; y < z[x].length-1; y++)
      {
        // one quad at a time
        // each quad's color is determined by the height value at each vertex
        // (clean this part up)
        stroke(0);
        //noStroke();
        fill(r,g,b,a);
        pushMatrix();
        beginShape(QUADS);
        translate(x*scl-w/2, y*scl-h/2, 0);
        vertex(0, 0, z[x][y]);
        vertex(scl, 0, z[x+1][y]);
        vertex(scl, scl, z[x+1][y+1]);
        vertex(0, scl, z[x][y+1]);
        endShape();
        popMatrix();
      }
    }
  }
  
  public void setColor(float red, float green, float blue, float alpha){
    r = red;
    g = green;
    b = blue;
    a = alpha;
  }
  //change the intensity of movement based on disturbLevel from mouse click
  public void disturb(){
   disturbLevel = disturbLevel + disturbLevel;
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Making_Ice" });
  }
}
