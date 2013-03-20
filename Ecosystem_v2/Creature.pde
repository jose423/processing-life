class Creature {
  Movement m; //movement associated with creature
  Landscape l; //landscape associated with creature
  PVector location, velocity, acceleration, resistance;
  int maxSpeed; //set max speed for velocity
  float mass; //mass affects the impact of the force

  Creature(Movement defaultM, Landscape defaultL, int _mass) {
    m = defaultM; //set initial movement
    l = defaultL; //set initial landscape
    maxSpeed = 5; //set max speed
    mass = _mass; //set mass
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps)
    resistance = new PVector(0, 0.02);
  }

  void update() {
    //apply forces dependant on Movement
    applyForce(m.applyMovement()); //apply movement associated with current creature
    applyForce(resistance); //all creatures apply resistance, change somewhere else
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }

  void display() {
    fill(200, 20, 20, 80);
    noStroke();
    ellipse(location.x, location.y, random(20), 20);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impact (1/100) vs. (1/1000)
    acceleration.add(force);
  }

  //assign Creature with particular movement (i.e. Perlin, Random)
  void setMovement(Movement _m) {
    m = _m;
  }
  // returns the current movement applied to the Creature
  Movement getMovement() {
    return m;
  }
  //assign Creature with particular Landcape (movement bounds)
  void setLandscape(Landscape _l) {
    l = _l;
  }
  // returns the current landscape (movement bounds) applied to the Creature
  Landscape getLandscape() {
    return l;
  }
  void checkEdges() {

    if (location.x > l.lWidth) {
      location.x = l.lWidth + l.lCorner.x;
      velocity.x *= -1;
    } 
    else if (location.x < l.lCorner.x) {
      velocity.x *= -1;
      location.x = l.lCorner.x;
    }

    if (location.y > l.lHeight) {
      velocity.y *= -1;
      location.y = l.lHeight + l.lCorner.y;
    }
    else if (location.y < l.lCorner.y) {
      velocity.y *= -1;
      location.y = l.lCorner.y;
    }
  }
}
