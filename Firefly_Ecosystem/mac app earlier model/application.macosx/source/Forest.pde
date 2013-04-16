class Forest extends Landscape {

  Forest() {
    lHeight = 200; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 600); //default
  }

  void display() {
    noStroke();
    fill(0, 170, 100); //green color
    ellipse(lCorner.x, lCorner.y, lWidth, lHeight);
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

