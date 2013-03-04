// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover m;
ArrayList<Attractor> attractors = new ArrayList<Attractor>();
ArrayList<Mover> movers = new ArrayList<Mover>();
void setup() {
  size(800, 400);
  background(0);
  //  m = new Mover(); 
  for (int i=0;i < 100; i++) {
    movers.add(new Mover());
  }

  attractors.add(new Attractor(width/2, height/2));
}

void draw() {
  background(0);

  //make all movers attracted to the newest attractor object using size as last index
  for (Mover mover: movers) {
    PVector force = attractors.get(attractors.size() - 1).attract(mover);
    mover.applyForce(force);
    mover.update();

    mover.display();
  }
}

void mousePressed() {
  attractors.remove(attractors.size() - 1);
  attractors.add(new Attractor(mouseX, mouseY));
}

void mouseReleased() {
}

