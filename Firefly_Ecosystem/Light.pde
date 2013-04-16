/**
The Light class is a moveable connectable object that shows a flickering yellow light and a lantern svg, 
it can be attached to a Lantern object and moved around with spring motions. Almost like a bungee cord hung the lantern.
**/
class Light {
  float mass = 100;
  float damping = 0.98;  // Arbitrary damping to simulate friction / drag 

  // For mouse interaction
  PVector dragOffset, location, velocity, acceleration;
  boolean dragging = false; //default not dragging

  PShape lanternsvg;
  
  Random generator = new Random();
  float gausColor; //for flicker of light
  float sdColor = 100;
  float meanColor = 200;
  float w, h; //width/height of light

  // Constructor
  Light(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    dragOffset = new PVector();
    lanternsvg = loadShape("lantern.svg");
    w = 75;
    h = 75;
  } 

  // Standard Euler integration
  void update() { 
    //apply gravity to the light source to drag it back to center
    PVector gravityLantern = new PVector(0, 2);
    applyForce(gravityLantern);

    velocity.add(acceleration);
    velocity.mult(damping);
    location.add(velocity);
    acceleration.mult(0);
  }

  // Newton's law: F = M * A
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }
  // Draw light and lantern svg
  void display() {
    float gaus = (float) generator.nextGaussian();
    gausColor = ( gaus * sdColor ) + meanColor;
    noStroke();
    fill(255, 255, gausColor);
    if (dragging) {
      fill(255);
    }
    ellipse(location.x, location.y, random(70, 90), random(70, 90));
    shape(lanternsvg, location.x-37, location.y-35, 75, 75);
  } 

  // The methods below are for mouse interaction

  // This checks to see if we clicked on the light
  void clicked(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = location.x-mx;
      dragOffset.y = location.y-my;
    }
  }
  void stopDragging() {
    dragging = false;
  }

  void drag(int mx, int my) {
    if (dragging) {
      location.x = mx + dragOffset.x;
      location.y = my + dragOffset.y;
    }
  }
}

