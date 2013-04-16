/**
 
 This class creates a FrictionSpace object which is a square in a location with different
 friction values associated which act upon the Creatures that fall within them. 
 FrictionSpace's contain and are bumped by Creatures,
 which turn blue and make a sound when they are hit.
 
 **/
class FrictionSpace {

  float x, y, w, h; //parameters to construct the space
  PVector l; //current creatures location
  float c; //space's friction value
  float xoff = 0.1; //for noise color
  PVector location; //location of space
  boolean isBumped; 
  boolean visitedBefore;
  boolean withinHalo;

  //construct landscape with particular size, location and friction value
  FrictionSpace(float _x, float _y, float _w, float _h, float _c) {
    location = new PVector(_x, _y);  
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    isBumped = false; //default has not been bumped by Creature
    visitedBefore = false; //default has not been visited more than once by Creature
    withinHalo = false; //default not within halo
  }
  //change color if mover has hit landscape
  void displayTouched() {
    noStroke();
    fill(0, random(200) + (noise(xoff)*255)%255, random(200) + (noise(xoff)*255)%255, 50);
    rect(x, y, w, h);
    xoff++;
  }
  //display space
  void display() {
    //if friction space is within halo of creature, illuminate slightly
    noStroke();
    if (withinHalo()) {
      fill(100, 0, 100, 30);
      rect(x, y, w, h);
    }
    else {
      fill(255, 0);
      rect(x, y, w, h);
    }
    xoff++;
  }
  void update() {
  }
  //return true if FrictionSpace falls within any Creature's halo
  boolean withinHalo() {
    return withinHalo;
  }

  //does landscape contain a particular mover?
  boolean contains(Creature m) {
    l = m.location;
    //if isBumped is true then this frictionspace has been visited before
    if (isBumped) {
      visitedBefore = true;
    }
    //the space falls within a Creatures halo of illumination, based on the total squares explored, withinHalo is true
    if (l.x + m.totalSpacesExplored > x && l.x + m.totalSpacesExplored < x + w && l.y + m.totalSpacesExplored > y && l.y + m.totalSpacesExplored < y + h) {
      withinHalo = true;
    }
    //Creature's location falls within FrictionSpace
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      println(m + "in friction space");
      isBumped = true;
      return true;
    }
    else 
      if (m instanceof Oscillator) {
      Oscillator o = (Oscillator)m;
      //return false;
      if (o.x > x && o.x < x + w && o.y > y && o.y < y + h) {
        isBumped = true;
        return true;
      }
      else return false;
    }
    else {
      return false;
    }
  }
  //Returns whether landscape has been bumped at least once in order to change color in display
  boolean bumped() {
    return isBumped;
  }
  //Returns whether FrictionSpace has been visited more than once, important for triggering sounds in FrictionStructure
  boolean visitedBefore() {
    return visitedBefore;
  }
}

