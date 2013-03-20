/**
 This class creates a creature that is very popular, meaning it attracts
 other creatures toward it, the attraction will be a seperate class but the
 style and some other tendencies will be in this class
 
 Give it a ocilating heartbeat glowy feeling
 
 **/
class PopularCreature extends Creature {
  PVector location;
  float opacity;

  PopularCreature(Movement defaultM, Landscape defaultL, int _mass) {
    super(defaultM, defaultL, _mass);
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    opacity = 1;
    resistance = new PVector(0.0001, 0.002);
  }
  void update() {
    //radio radio
    if (opacity > 90) {
      opacity = 10;
    }
    else {
      opacity++;
    }
    
    applyForce(m.applyMovement()); //apply movement associated with current creature
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }
  void display() {
    fill(0, opacity);
    rect(location.x, location.y, 10, 10);
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

