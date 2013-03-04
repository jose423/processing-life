/**
* Author: Maya Richman 
* Title: Baby You Can Drive My Unrealistic Car
* Date: March 1, 2013
* Original: Daniel Shiffman
**/

//Press d to drive and b to brake

Mover mover;

void setup() {
  size(800, 200);
  mover = new Mover();
}

void draw() {
  background(0, 10, 140);
  fill(100, 250, 100);
  noStroke();
  rect(0, height/2, width, height);
  fill(190);
  rect(0, height/2, width, 40);
    
  
  mover.update();
  mover.checkEdges();
  mover.display();

}
void keyPressed() {
  if (key == 'd') {
    mover.acceleration.set(-0.01, 0.0, 0);
  } 
  if (key == 'b') {    
    //slowing down is just removing acceleration and decrementing velocity methodically
    mover.acceleration.set(0.0, 0.0, 0); 
    mover.applyBrakes();
  }
}

