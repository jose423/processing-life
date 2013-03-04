/*
remove movers from arraylist after they hit the bottom
 upon click make new set of however many mover to drop
 */




// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

ArrayList<Mover> movers = new ArrayList<Mover>();
ArrayList<Landscape> landscapes = new ArrayList<Landscape>();
List<Landscape> landscapesSync = Collections.synchronizedList(landscapes);
float c = 0.2;
int i = 1;
int n = 0;
float frictionIncrease = 0.1;
int totalMovers = 40;

void setup() {
  size(600, 700);
  randomSeed(1);
  for (int i=0;i<totalMovers;i++) {
    movers.add(new Mover(random(1, 4), random(width), 0));
  }
  for (int i=0;i<20;i++) {

    //could make landscape objects long lines of conjoined squares instead of initializing them this way
    landscapesSync.add(new Landscape(0+n, 70+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 100+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 130+n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(0+n, 200+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 230+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(0+n, 260+n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(70+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(100+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(130+n, 0+n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(200+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(230+n, 0+n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(260+n, 0+n, 10, 10, frictionIncrease));

    //--------------------------------------------------------------------

    landscapesSync.add(new Landscape(width-n, height-70-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-100-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-130-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-n, height-200-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-230-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-260-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-70-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-100-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-130-n, height-0-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-200-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-230-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-260-n, height-0-n, 10, 10, frictionIncrease));




    n += 10;
    frictionIncrease++;
  }
}

void draw() {
  background(0);

  //  cycle through landscapesSync and display
  for (Landscape landscape : landscapesSync) {
    landscape.display();
    if (landscape.bumped()) {
      landscape.update();
    }
  }

  for (Mover mover : movers) {
    PVector wind = new PVector(0.01, 0);
    PVector gravity = new PVector(0, 0.1*mover.mass);

    c = 0.05;

    //does landscape contain mover?
    for (Landscape landscape : landscapesSync) {
      if (landscape != null) {
        if (landscape.contains(mover)) { //contains checks the boundaries that the landscape has
          c = landscape.c;
          landscape.update(); //turn blue if landscape contains mover
        }
      }
    }

    PVector friction = mover.velocity.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);

    mover.applyForce(friction);
    mover.applyForce(wind);
    mover.applyForce(gravity);

    mover.update();
    mover.display();
    if (mover.checkEdges()) {
      movers.remove(mover);
      break;
    }
  }
}
void mouseClicked() {
  for (int i=0;i<totalMovers;i++) {
    movers.add(new Mover(random(1, 4), random(width), 0));
  }
}

