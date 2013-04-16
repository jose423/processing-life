/**
 This class creates Latern objects that are attached to Light objects. The methods are from Nature of Code for the Spring and Bob class.
 **/
class Lantern {

  PVector location, velocity, acceleration; //dictates where latern can be pulled and how fast it travels

  float len; // rest length
  float k = 0.1; //moves slower

  Lantern(float x, float y, int l) {
    location = new PVector(x, y);
    len = l;
  }
  // Calculate spring force
  void connect(Light l) {
    // Vector pointing from anchor to bob location
    PVector force = PVector.sub(l.location, location);
    // What is distance
    float d = force.mag();
    // Stretch is difference between current distance and rest length
    float stretch = d - len;

    // Calculate force according to Hooke's Law
    // F = k * stretch
    force.normalize();
    force.mult(-1 * k * stretch);
    l.applyForce(force);
  }
  // Constrain the distance between bob and anchor between min and max
  void constrainLength(Light l, float minlen, float maxlen) {
    PVector dir = PVector.sub(l.location, location);
    float d = dir.mag();
    // Is it too short?
    if (d < minlen) {
      dir.normalize();
      dir.mult(minlen);
      // Reset location and stop from moving (not realistic physics)
      l.location = PVector.add(location, dir);
      l.velocity.mult(0);
      // Is it too long?
    } 
    else if (d > maxlen) {
      dir.normalize();
      dir.mult(maxlen);
      // Reset location and stop from moving (not realistic physics)
      l.location = PVector.add(location, dir);
      l.velocity.mult(0);
    }
  }
  //display lantern object
  void display() {
    noStroke();
    fill(255, 10);
    strokeWeight(1);
    rectMode(CENTER);
    rect(location.x, location.y, 10, 10);
  }
  //display line between lantern and light and origin point of the "rope"
  void displayLine(Light l) {
    strokeWeight(2);
    stroke(0);
    line(l.location.x, l.location.y, location.x, location.y);
  }
}
