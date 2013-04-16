class Ocean extends Landscape {
  float angle = 0.1;
  Ocean() {
    lHeight = height; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 0); //default
  }
  void update() {
    angle = angle + 0.02; //update angle to cause wave motion
  }
  void display() {
    noStroke();
    fill(255);
    a.display();
  }
}

