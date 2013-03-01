/**
* Author: Maya Richman
* Title: Ecosystem v.1.
* Date: Feb 25, 2013
**/

abstract class Landscape {
  int lwidth, lheight;
  PVector center;
  Landscape(int lWidth, int lHeight) {
    this.lwidth = lWidth;
    this.lheight = lHeight;
    center = new PVector(0.0, 0.0);
  }
  int getWidth() {
    return lwidth;
  }
  int getHeight() {
    return lheight;
  }
  float getCenterX() {
    return center.x;
  }
  float getCenterY() {
    return center.y;
  }
  void display() {
    fill(100, 150, 0);
    noStroke();
    rect(center.x, center.y, lheight, lwidth);
  }
}

