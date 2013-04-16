/**
 This class will have a visual element and is intended for creation of attractor objects placed by the user,
 the Popular Creature class has the attract method to attract other creatures
 **/
class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  PVector dragOffset;  // holds the offset for when object is clicked on
  PShape hands, welcome, grab;   //mouse svg

  Attractor(float _x, float _y) {
    location = new PVector(_x, _y);
    G = 1;
    //Hands designed by Veysel Kara from The Noun Project
    welcome = loadShape("welcome.svg");
    //Hands designed by Rémy Médard from The Noun Project
    grab = loadShape("grab.svg");
  }
  //show hand based upon repeller or attractor
  void display() {
    if (isAttractor) {
      hands = welcome;
    }
    else {
      hands = grab;
    }
    //draw svg hands
    shape(hands, location.x, location.y, 75, 75);
  }
  //reverse Attractor force (repel,attract)
  void reverseAttractor() {
    if (isAttractor) {
      isAttractor = false;
    }
    else {
      isAttractor = true;
    }
  }
  //is the current attractor repellling or attracting
  boolean isAttractor() {
    return isAttractor;
  }
}

