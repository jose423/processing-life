class Perlin_Movement extends Movement {

  float x, y, seedx, seedy;
  PVector force;
  Perlin_Movement(float _seedx, float _seedy) {
    seedx = _seedx;
    seedy = _seedy;
  }
  void update() {
    float accelerationNoiseX = noise(seedx);
    float accelerationNoiseY = noise(seedy);
    x = map(accelerationNoiseX, 0, 1, 10, -10);
    y = map(accelerationNoiseY, 0, 1, -10, 10);
    seedx =  seedx + 0.1;
    seedy = seedy + 3;
  }

  PVector applyMovement() { // this method will return a PVector to use in the Creature's applyForce() method, the PVector represents the amount acceleration changed
    //should I map the value to the confines of the landscape it is in
    force = new PVector(x, y);
    return force;  //return pvector with added value, in this case it is random
  }
  float getX() {
    return force.x;
  }
  float getY() {
    return force.y;
  }
}

