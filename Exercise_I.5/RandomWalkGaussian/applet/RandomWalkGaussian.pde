// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker w;

void setup() {
  size(400,400);
  frameRate(5);
  // Create a walker object
  w = new Walker();

}

void draw() {
  background(0);
  // Run the walker object
  w.walk();
  w.display();
}



