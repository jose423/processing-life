class Wave {
  float startAngle;
  float angleVel;
  ArrayList<PVector> erasure = new ArrayList<PVector>();
  int opacity;
  PVector location, acceleration, velocity, run;
  float y;
  int maxSpeed = 3;
  Wave() {
    location = new PVector(0.01, height/2);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    startAngle = 0.80;
    angleVel = 0.20;
    opacity = 100;
    run = new PVector(0.01, 0);
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    run.normalize();
    run.mult(1.1);
    applyForce(run);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }
  void display() {
    for (PVector p: erasure) { //erase area where wave moves
      fill(255,10);
      rect(p.x, p.y, 10, 2);
    }

    startAngle += 0.015;
    float angle = startAngle;

    for (float x = location.x; x <= width; x += 2) {
      println(location.x);
      float y = map(sin(angle), -1, 1, location.x/2, location.y/4);
      stroke(0);
      fill(255, 50);
      strokeWeight(1);
      ellipse(x, y, 10, 10);
      fill(255, 80);
      ellipse(x, y, 2, 2);
      angle += angleVel;
      erasure.add(new PVector(location.x, y));
    }
  }
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    }
  }
}

