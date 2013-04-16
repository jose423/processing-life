/**
 
 This class creates Ocillator objects that hover around the Attractor (hand) and do not cause sound when they hover over the landscape.
 Original Code from Daniel Shiffman. These creatures do not flicker in unison like the others. They pivot around the location the are constructed with.
 
 **/

class Oscillator extends Creature {   

  PVector angle;
  PVector velocity;
  PVector amplitude;
  PVector location;

  Oscillator(Landscape defaultL, float seedx, float seedy, float _x, float _y) {
    super(defaultL, seedx, seedy);
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(20, width/4), random(20, height/4));
    location = new PVector(_x, _y);
    blink = true;
  }   

  void update() {
    //change angle's velocity for ocillation
    angle.add(velocity);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    spirit--;
    //decrease lifeforce
    lifeforce = lifeforce - 2;
  }   
  void display() {   
    float randomSize = random(12);
    float x = sin(angle.x)*amplitude.x;
    float y = sin(angle.y)*amplitude.y;
    //map lifeforce to opacity to fade when they get older and die :(
    float opacity = map(lifeforce, 0, MAXLIFESPAN, 0, 255);    //if spirit is greater than 300 use random flickering pattern, otherwise occilate between size 6 and 15 for a standardized flicker simulating emergence
    //if spirit is less than 300, blink, meaning occilate between two sizes, 6 and 12
    if (spirit > 300) {
      //size = gausSize;
      size = randomSize;
    }
    else {
      if (blink) {
        size = 6;
        blink = false;
      }
      else {
        size = 15;
        blink = true;
      }
    }
    pushMatrix();
    translate(x, y);
    //size of firefly creature determined by random generator for un-patterned flickering effect
    ellipse(location.x, location.y, randomSize, randomSize);
    stroke(255, 255, 10, opacity);
    fill(255, opacity);
    popMatrix();
  }
}   

