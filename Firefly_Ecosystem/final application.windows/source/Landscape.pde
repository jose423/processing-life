/**
The is the Landscape class, Landscapes have a dedicated attractor, a size and any number of display option
**/
abstract class Landscape {
  float lHeight;
  float lWidth; 
  PVector lCenter, lCorner;
  Attractor a;

  Landscape() {
    lHeight = height; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 0); //default
    a = new Attractor(lWidth/2, lHeight/2);
  }
  void display() {
    a.display();
    noStroke();
    rect(lCorner.x, lCorner.y, lWidth, lHeight);
  }
  float getHeight() {
    return lHeight;
  }
  float getWidth() {
    return lWidth;
  }
  //assign new attractor to landscape
  void setAttractor(Attractor _a) {
    a = _a;
  }
  //return the attractor
  PVector getAttractorLocation() {
    return a.location;
  }
  boolean isAttractor(){
   return a.isAttractor(); 
  }
  void reverseAttractor(){
    a.reverseAttractor();
  }
}

