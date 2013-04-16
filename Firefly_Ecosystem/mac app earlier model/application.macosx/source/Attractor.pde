/**
 This class will have a visual element and is intended for creation of attractor objects placed by the user,
 the Popular Creature class has the attract method to attract other creatures
 
 **/
class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  PVector dragOffset;  // holds the offset for when object is clicked on

  Attractor(float _x, float _y) {
    location = new PVector(_x, _y);
    mass = 1;
    G = 1;
    dragOffset = new PVector(0.0, 0.0);
  }
  void display() {
    fill(255);
    ellipse(location.x,location.y,20,20);
  }
  PVector attract(Creature m) {
    PVector force = PVector.sub(location, m.location);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 0.0, 10.0);    // Limiting the distance to eliminate "extreme" results for very close or very far objects

    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
    force.mult(strength);                                  // Get force vector --> magnitude * direction

    return force;
  }
}

