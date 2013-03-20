class Landscape {
  float lHeight;
  float lWidth; 
  PVector lCenter, lCorner;
  
  Landscape() {
    lHeight = height; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2,lHeight/2);
    lCorner = new PVector(0,0); //default
  }
  void display() {
    fill(100);
    noStroke();
    rect(lCorner.x,lCorner.y,lWidth,lHeight);
  }
  float getHeight() {
    return lHeight;
  }
  float getWidth() {
    return lWidth;
  }
}

