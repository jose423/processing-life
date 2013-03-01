/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/39662*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
import processing.pdf.*;


class Inkblot {

  PVector blot = new PVector(0, 0);
  boolean colorize;

  Inkblot() {
    blot.x = mouseX;
    blot.y = mouseY;
    colorize = false;
  }

  void draw() {

    strokeWeight(random(15)*random(5));
    blot.x = mouseX;
    blot.y = mouseY;

    if (!colorize) {
      stroke(0, random(90, 100));
      point(blot.x, blot.y);
      point((600-blot.x), blot.y);
    }
    else {
      stroke(random(255), random(255), random(255));
      point(blot.x, blot.y);
      point((600-mouseX), mouseY);
    }
  }
}

