/**
 This class creates a creature that is very popular, meaning it attracts
 other creatures toward it, the attraction will be a seperate class but the
 style and some other tendencies will be in this class
 
 Give it a ocilating heartbeat glowy feeling
 
 **/
class PopularCreature extends Creature {
  float opacity;
  float G;       // Gravitational Constant
  PVector location;   // Location
  PVector dragOffset;  // holds the offset for when object is clicked on
  Perlin_Movement m;
  PVector wind;
  PopularCreature(Perlin_Movement defaultM, Landscape defaultL, int _mass) {
    super(defaultM, defaultL, _mass);
    m = defaultM;
    location = new PVector(random(l.getWidth())/2, random(l.getHeight())/2); //choose random location within bounds of_l
    opacity = 1;
    resistance = new PVector(0.0, 0.0);
    mass = 1;
    G = 10;
    dragOffset = new PVector(0.3, 0.1);
    wind = new PVector(0,0);
  }
  void update() {
    if (opacity > 90) {
      opacity = 10;
    }
    else {
      opacity++;
    }
    //update movement before applying
    m.update();
    applyForce(wind);
    applyForce(m.applyMovement()); //apply movement associated with current creature
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }
  void display() {
    stroke(255);
    strokeWeight(1);
    fill(0, opacity);
    rect(location.x, location.y, 10, 10);
  }
  void checkEdges() {

    if (location.x > l.lWidth) {
      location.x = l.lWidth + l.lCorner.x;
      velocity.x *= -1;
    } 
    else if (location.x < l.lCorner.x) {
      location.x = l.lCorner.x;
      velocity.x *= -1;
    }

    if (location.y > l.lHeight) {
      location.y = l.lHeight + l.lCorner.y;
      velocity.y *= -1;
    }
    else if (location.y < l.lCorner.y) {
      location.y = l.lCorner.y;
      velocity.y *= -1;
    }
  }
}

