// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover mover;
float max;
float up;

void setup() {
  size(800, 200);
  mover = new Mover();
  up = 100;
}

void draw() {
  background(0);

  mover.update();
  mover.checkEdges();
  mover.display();
}

void keyPressed() {
  max = mover.getMax();
  if (key == CODED) {
    if (keyCode == UP) {
      if(up < width){
      max++;
      fill(0);
      ellipse(up, 150, 20, 20);
      up = up + 20;
      mover.setMax(max);
      println(max);
      }
    }
    if (keyCode == DOWN) {
      if (up > 0) {
        max--;
        ellipse(up, 150, 20, 20);
        up = up - 20;
        mover.setMax(max);
        println(max);
      }
    }
  }
}

