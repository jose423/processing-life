//class defines a certian type of movement that can be applied to any object with location

/**
 If the movement is random the class will create a random seed and will have methods to determine what acceleration and velocity should be for the object it is applied to
 
 **/
class Movement {

  float randomVal;
  float x, y, seedx, seedy;

  Movement() {
    randomVal = random(80); //all movements have this default seed so they move the same
    seedx = int(random(10));
    seedy = int(random(10));
  }
  void update() {

    float accelerationNoiseX = noise(seedx);
    float accelerationNoiseY = noise(seedy);
    x = map(accelerationNoiseX, 0, 1, -1, 1);
    y = map(accelerationNoiseY, 0, 1, -1, 1);
    seedx =  seedx + 0.1;
    seedy = seedy + 0.1;
  }

  PVector applyMovement() { // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
    //should I map the value to the confines of the landscape it is in
    return new PVector(x, y, 0);  //return pvector with added value, in this case it is random
  }
}

