/**
 This class defines an abstract class Movement that can be applied to any Creature.
 **/
abstract class Movement {
  Movement() {}
  void update() {}
  PVector applyMovement() { // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
    return new PVector(random(1), random(1));  //return pvector with added value, in this case it is random
  }
}

