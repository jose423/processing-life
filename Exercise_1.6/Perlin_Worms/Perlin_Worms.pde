/**
* Author: Maya Richman 
* Title: Three Dee Perlin Worms
* Date: March 1, 2013
* Original: Daniel Shiffman
**/

// A Mover object
ArrayList<Mover> movers = new ArrayList<Mover>();

void setup() {
  size(800, 400);
  background(0);
  movers.add(new Mover(width, height,3,100));
}

void draw() {
  for (Mover mover: movers) {  
    // Update the location
    mover.update();
    // Display the Mover
    mover.display();
  }
}
void mouseClicked() {
  movers.add(new Mover(mouseX, mouseY, int(random(1000)),int(random(1000))));
}

