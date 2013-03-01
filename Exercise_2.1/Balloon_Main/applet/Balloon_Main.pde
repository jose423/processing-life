//Using forces, simulate a helium-filled balloon floating upward and bouncing off the top of a window. 
//Can you add a wind force that changes over time, perhaps according to Perlin noise?
Balloon hell;
PVector wind, gravity;
float xoff = 0.0;

ArrayList<Balloon> helloBalloons = new ArrayList<Balloon>();
void setup() {
  size(1000, 500);
  background(0);
  //  hell = new Balloon(width/2);
  //make wind change over time in draw
  wind = new PVector(0.01, 0);
  gravity = new PVector(0, -0.2);
}

void draw() {
  background(0);

  //update one balloon
  //  hell.update();
  //  hell.display();
  //  hell.applyForce(gravity);
  //  windChanges();
  //  hell.applyForce(wind);
  windChanges();
  //update all balloons in arraylist
  for (Balloon balloon: helloBalloons) {
    balloon.update();
    if (balloon.checkEdges()) {
      helloBalloons.remove(balloon);
      break;
    }
    balloon.display();
    balloon.applyForce(gravity);
    balloon.applyForce(wind);
  }
}
//when mouse is clicked make new Balloon object and add to arraylist helloBalloons
void mouseClicked() {
  helloBalloons.add(new Balloon(mouseX));
}
void mouseDragged() {
  //right now wind depends on clicks, but should eventually depend on perlin noise
  //  wind.mult(0);
}

void windChanges() {
  float windChange = noise(xoff);
  xoff = xoff + 0.01;
  wind.set(windChange*0.09, 0.0, 0.0);
}

