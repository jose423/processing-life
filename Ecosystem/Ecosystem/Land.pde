/**
* Author: Maya Richman
* Title: Ecosystem v.1.
* Date: Feb 25, 2013
**/

class Land extends Landscape {
  PVector centerGround;
  int groundh, groundw;
  
  Land (int groundh, int groundw) {
    super(groundh, groundw);
    this.groundh = groundh;
    this.groundw = groundw;
    centerGround = center;
  }
  void display() {
    fill(100, 150, 0);
    noStroke();
    rect(centerGround.x, centerGround.y, groundh, groundw);
  }
  float getCenterX() {
    return centerGround.x;
  }
  float getCenterY() {
    return centerGround.y;
  }
    int getWidth() {
    return groundw;
  }
  int getHeight() {
    return groundh;
  }

}

