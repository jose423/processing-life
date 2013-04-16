/**
This class defines a Sky object that takes up the entire sketch size and displays an attractor object. 
This class has the potential to apply other bounds on the Creatures and designs on the background, but currently just shows the attractor. This is an underutilized class
and was meant for more complex Landscape visuals in prior iterations
**/
class Sky extends Landscape {
  Sky() {
    lHeight = height; //default height and width is the size of the applet
    lWidth = width;
    lCenter = new PVector(lWidth/2, lHeight/2);
    lCorner = new PVector(0, 0); //default
  }
  void display() {
    noStroke();
    a.display();
  }
}

