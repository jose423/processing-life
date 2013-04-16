//class defines a certian type of movement that can be applied to any object with location

/**
 If the movement is random the class will create a random seed and will have methods to determine what acceleration and velocity should be for the object it is applied to
 
 **/
class Movement {

  Movement() {
  }
  void update() {
  }

  PVector applyMovement() { // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
    //should I map the value to the confines of the landscape it is in
    return new PVector(random(1),random(1));  //return pvector with added value, in this case it is random
  }
}

