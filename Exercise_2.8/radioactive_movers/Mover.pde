// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float sizeMover;
  int i = 1;
  Mover() {
    location = new PVector(random(400),random(50));
    velocity = new PVector(0.9,0);
    acceleration = new PVector(0,0);
    mass = 1;
    sizeMover = 3;
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    sizeMover += .009;
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    noStroke();
    fill(127,0,((noise(i++)*1000)+127)%255,60);
    smooth();
    ellipse(location.x,location.y,sizeMover,sizeMover);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }

  }

}



