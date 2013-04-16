/**
Produces a RandomMovement that can be applied to any Creature
**/
class Random_Movement extends Movement {
  PVector force;

  Random_Movement() {
    force = new PVector(random(-1.0, 1.0), random(-1.0, 1.0));
  }
  void update() {
    force = new PVector(random(-1.0, 1.0), random(-1.0, 1.0));
  }
  // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
  PVector applyMovement() { 
    //return pvector with added value, in this case it is random
    return force;
  }
}

