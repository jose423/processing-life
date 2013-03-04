/**
 Author: Maya
 Title: Invisible
 Date: Feb 20, 2013
 **/

/**
Instead of objects bouncing off the edge of the wall,
create an example in which an invisible force pushes
back on the objects to keep them in the window. Can you
weight the force according to how far the object is from
an edge—i.e., the closer it is, the stronger the force?


when the location.x, location.y of an object 
reaches a certian distance from the wall
apply a force pushing the opposite direction of movement
then set back to 0 after displaying it
**/


Mover m;

void setup() {
  size(640,360);
  m = new Mover(); 
}

void draw() {
  background(255);

  PVector wind = new PVector(0.01,0);
  PVector gravity = new PVector(0,0.3);
  m.applyForce(wind);
  m.applyForce(gravity);


  m.update();
  m.display();
  m.checkEdges();

}





