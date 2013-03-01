//Using forces, simulate a helium-filled balloon floating upward and bouncing off the top of a window. 
//Can you add a wind force that changes over time, perhaps according to Perlin noise?
class Balloon {

  PVector location, velocity, acceleration;  

  Balloon(float _x) {
    location = new PVector(_x, height);
    velocity = new PVector(0, -0.05);
    acceleration = new PVector(0, 0);
  }

  void display() {
    fill(245, 0, 0, 90);
    smooth();
    noStroke();
    ellipse(location.x, location.y, 50, 55);
    fill(255);
    triangle(location.x - 20,location.y,location.x,location.y,location.x + 20,location.y);    
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  //when balloon hits the top of the sketch where x <= 0, have bounce back, otherwise if balloon leaves screen delete from the arraylist of balloons
  boolean checkEdges() {
    if (location.y <= 0) {
      velocity.y *= -0.7;
      location.y = 0;
      return false;
    }    
    if (location.x >= width || location.x <= 0) {
      return true;
    }
    return false;
  }
}

