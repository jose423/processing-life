class Forest extends Landscape{

  Forest() {
    lHeight = 200; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2,lHeight/2);
    lCorner = new PVector(0,400); //default
  }
 
  void display() {
    fill(0,200,100); //green color
    rect(lCorner.x,lCorner.y,lWidth,lHeight);
  }
   
}
