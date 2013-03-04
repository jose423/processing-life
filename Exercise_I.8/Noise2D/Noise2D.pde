/**
 * Title: Ahh
 * Author: Maya Richman
 **/
//Original
// Daniel Shiffman
// The Nature of Code
// http://natureofcode.com

//running on the sidewalk really fast

Noise noise1, noise2;
int dheight = 20;
Divider d1, d2, d3;
float center = 400;
Divider[] allDividers = new Divider[10];
int distance = 40;
int count = 0;

void setup() {
  size(800, 400);
  noise1 = new Noise(0.1, 5, 0.2, 0.0, 0.0);
  noise2 = new Noise(0.9, 1, 0.8, 0.2, 0.1);

  for (int i = 0; i < allDividers.length; i++) {

    allDividers[i] = new Divider(center, height-distance*i, 0, 4.2);
  }
}

void draw() {
  noise1.draw();
  noise2.draw();

  for (int i = 0; i < allDividers.length; i++) {

    if (allDividers[i].checkLocation()) {
      allDividers[i].location.y -= (distance)*allDividers.length-1;
    }
//    background(255);
    allDividers[i].draw();
  }
}

