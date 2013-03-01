/**
* Author: Maya Richman
* Title: Ecosystem v.1.
* Date: Feb 25, 2013
**/

/**
 Class that changes the gradient of colors on the land and ocean and movers?, shadow?
 **/
class Sun {
  // Constants
  int Y_AXIS = 1;
  int X_AXIS = 2;
  color b1, b2, c1, c2;


  Sun() {
    // Define colors
    b1 = color(255);
    b2 = color(0);
    c1 = color(255,215,0);
    c2 = color(255, 0, 153);
  }
  void update() {
    // Foreground
    setGradient(50, 90, 540, 80, c1, c2, Y_AXIS);
  }

  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

//    noFill();

    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        //ellipse(x, i, x+w, i);
        //ellipse(x, x+w, i, i);
        fill(c,2);
        ellipse(width - width/5,height - height/5,i,i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}

