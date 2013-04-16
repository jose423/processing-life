/**
 This class defines a PerlinMovement which is an extension of the Movement class, that can be applied to a Creature.
 This ensures any implementation of the Movement class can apply to any Creatures.
 
 **/

class Perlin_Movement extends Movement {

  float x, y, seedx, seedy; //seeds for perlin movement
  PVector force;
  
  Perlin_Movement(float _seedx, float _seedy) {
    seedx = _seedx;
    seedy = _seedy;
  }
  //map noise to acceleration
  void update() {
    float accelerationNoiseX = noise(seedx);
    float accelerationNoiseY = noise(seedy);
    x = map(accelerationNoiseX, 0, 1, 10, -10);
    y = map(accelerationNoiseY, 0, 1, -10, 10);
    seedx =  seedx + 0.1;
    seedy = seedy + 0.3;
  }
  // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
  PVector applyMovement() {
    force = new PVector(x, y);
    //return pvector with added value, in this case it is random
    return force;
  }
}

