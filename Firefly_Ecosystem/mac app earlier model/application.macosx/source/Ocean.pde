class Ocean extends Landscape {
  float angle = 0.1;
  Ocean() {
    lHeight = 500; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 0); //default
  }
  void update() {
    angle = angle + 0.02; //update angle to cause wave motion
  }
  void display() {
    noStroke();
    fill(0, 190, 200, 100);
    rect(lCorner.x, lCorner.y + sin(angle)*40, lWidth, lHeight);
    fill(0, 200, 255, 90);
    rect(lCorner.x, lCorner.y + sin(angle)*30, lWidth, lHeight);
    fill(0, 190, 240, 80);
    rect(lCorner.x, lCorner.y + sin(angle)*20, lWidth, lHeight);
    fill(0, 10, 255, 70);
    rect(lCorner.x, lCorner.y + sin(angle)*10, lWidth, lHeight);
    fill(0, 10, 255, 60);
    rect(lCorner.x, lCorner.y, lWidth, lHeight);
  }
}

