// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

/*
instead can the mover accelerate when it hits another mover?
 what is the best way to accomplish this? 
 We don't want every mover to have to know about all other movers
 Maybe let's start where there are new boundaries the mover is limited to,
 for example fish creatures must stay in the water
 add force that makes the mover struggle against the tide? fiesty? 
 */
Mover m;
Ocean o;
Moon ourMoon;
int currentTide;
int totalMovers = 200;
Mover k;
Mover[] allMovers = new Mover[totalMovers];
PVector wind, gravity, resistance;
void setup() {
  size(700, 700);
  o = new Ocean(300, 500);
  m = new Mover(o, 1);
  k = new Mover(o, 3);
  ourMoon = new Moon();
  smooth();
  wind = new PVector(0.2, 0.01);
  gravity = new PVector(0, 0);
  resistance = new PVector(2, 0);

  for (int i = 0; i<totalMovers; i ++) {
    allMovers[i] = new Mover(o, i+1);
  }
}

void draw() {
  background(255);

  for (int i = allMovers.length - 1; i >= 0; i--) {
    allMovers[i].applyForce(wind);
    allMovers[i].applyForce(gravity);

    if (currentTide == 1 ) {
      resistance.mult(abs((allMovers[i].getSpirit()/100.0)));
      allMovers[i].applyForce(resistance);
      allMovers[i].setSpirit(abs(allMovers[i].getSpirit() - 0.02));
    }
    else {
      resistance.div(1.001);
      allMovers[i].applyForce(resistance);
    }
    allMovers[i].update();
    allMovers[i].display();
    allMovers[i].checkEdges(o);
    
  currentTide = o.checkTide(ourMoon);  //too much in one method?
  o.update();
  o.display();

  }

  //  m.applyForce(wind);
  //  m.applyForce(gravity);
  //  k.applyForce(gravity);
  //  k.applyForce(wind);

//  currentTide = o.checkTide(ourMoon);  //too much in one method?
//  o.update();
//  o.display();

  //if currentTide is high and the mover has a lot of spirit, make force to help push against the tide
  // println(m.getSpirit());

  //  if (currentTide == 1 ) {
  //    resistance.mult(abs((m.getSpirit()/100.0)));
  //    m.applyForce(resistance);
  //    m.setSpirit(abs(m.getSpirit() - 0.02));
  //  }
  //  else {
  //    resistance.div(1.001);
  //    m.applyForce(resistance);
  //  }

  //  k.update();
  //  k.display();
  //  k.checkEdges(o);
  //  m.update();
  //  m.display();
  //  m.checkEdges(o);
}
void mousePressed() {
  if (mouseX >= o.getCenterY() && mouseX < o.getWidth() + o.getCenterY()) {
    m.agitate();
  }
  if (mouseY >= o.getCenterX() && mouseY < o.getHeight() + o.getCenterX()) {
    m.agitate();
  }
}

