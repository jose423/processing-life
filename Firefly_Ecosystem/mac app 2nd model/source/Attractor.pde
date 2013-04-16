/**
 This class will have a visual element and is intended for creation of attractor objects placed by the user,
 the Popular Creature class has the attract method to attract other creatures
 
 **/
class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  PVector dragOffset;  // holds the offset for when object is clicked on
  float len;
  float k = 0.2;
  //mouse svg
  PShape hands;

  Attractor(float _x, float _y) {
    location = new PVector(_x, _y);
    mass = 1;
    G = 1;
    dragOffset = new PVector(0.0, 0.0);
    len = 10;
    //Hands designed by Rémy Médard from The Noun Project
    hands = loadShape("grab.svg");
  }

  // Calculate spring force
  void connect(Creature c) {
    // Vector pointing from anchor to bob location
    PVector force = PVector.sub(c.location, location);
    // What is distance
    float d = force.mag();
    // Stretch is difference between current distance and rest length
    float stretch = d - len;

    // Calculate force according to Hooke's Law
    // F = k * stretch
    force.normalize();
    force.mult(-1 * k * stretch);
    c.applyForce(force);
  }
  void display() {
    shape(hands,location.x,location.y, 50,50);
//    fill(255);
//    ellipse(location.x, location.y, 10, 10);
  }
  //Returns PVector that represents magnitude of attract force for a Creature
  PVector attract(Creature m) {
    PVector force = PVector.sub(location, m.location);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 0.0, 10.0);    // Limiting the distance to eliminate "extreme" results for very close or very far objects

    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G) / (d * d);      // Calculate gravitional force magnitude
    force.mult(strength);                                  // Get force vector --> magnitude * direction

    return force;
  }
}

