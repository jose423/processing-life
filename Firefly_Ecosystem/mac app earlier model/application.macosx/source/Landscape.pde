class Landscape {
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
  void update(){
    
  }
  void display() {
    a.display();
    
    fill(100);
    noStroke();
    rect(lCorner.x, lCorner.y, lWidth, lHeight);
  }
  float getHeight() {
    return lHeight;
  }
  float getWidth() {
    return lWidth;
  }
  void setAttractor(Attractor _a) {
    a = _a;
  }
  Attractor getAttractor() {
    return a;
  }
  PVector getCreatureAttractorForce(Creature _c) {
    return a.attract(_c);
  }
}

