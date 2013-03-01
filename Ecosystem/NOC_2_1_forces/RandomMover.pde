class RandomMover extends Creature {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float spirit;
  int age;
  Landscape l;
  int maxspeed;
  float maxforce;
  int r, g, b;
  float r2;
  int x = 1;
  float creatureSize;
  int step;

  RandomMover(Landscape l, int age) {
    super(l, age);
    location = new PVector(l.getCenterX(), l.getCenterY()); //Vector determines location of mover
    velocity = new PVector(0, 0.2, 0.3); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps) 
    mass = 2*age; //start with mass equal to 1
    this.spirit = spirit;
    this.age = age;
    this.l = l;
    maxspeed = 5;
    maxforce = 0.1;
    this.r = 0; 
    this.g = 0;
    this.b = 255;
    r2 = 6.0;
    creatureSize = age*2;
    step = 100;
  }
  // Randomly move up, down, left, right, or stay in one place
  void update() {
    int choice = int(random(4));
    //randomly decrement or increment x or y
    if (choice == 0) {
      location.x++;
    } 
    else if (choice == 1) {
      location.x--;
    } 
    else if (choice == 2) {
      location.y++;
    } 
    else {
      location.y--;
    }

    float prob = random(1);
    //each option is as likely and takes 4 steps more than the original
    if (prob < .25) {
      location.x=location.x+step;
    }
    if (prob >= .25 && prob < .50) {
      location.x=location.x-step;
    }
    if (prob >= .50 && prob < .75) {
      location.y=location.y+step;
    }
    if (prob >= .75 && prob < 1) {
      location.y=location.y-step;
    }

    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(30.0);
    acceleration.mult(0); //resets acceleration
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); //force is impacted by mass, the larger mass the smaller the impace (1/100) vs. (1/1000)
    acceleration.add(f);
  }
  //base off of spirit, less spirit more likely to follow pvector target
  void seek(PVector target) {
    PVector desired = helperReaction(target);
    PVector steer = PVector.sub(desired, velocity);

    steer.limit(maxforce);
    desired.limit(maxforce);

    applyForce(steer);
    applyForce(desired);

    if ((creatureSize+0.2)%40.0 > 1.0) {
      creatureSize = (creatureSize+0.02)%40.0;
    }
    else {
      creatureSize = 50.0;
    }
  }
  void flee(PVector target) {
    PVector desired = helperReaction(target);
    //PVector steer = PVector.add(desired, velocity);
    //steer.limit(0.02);
    desired.limit(0.02);

    //applyForce(steer);
    applyForce(desired);

    if ((creatureSize+0.2)%10.0 > 1.0) {
      creatureSize = (creatureSize-0.002)%10.0; //cool popping effect when reaches 10 x 10
    }
    else {
      creatureSize = 10.0;
    }
    //creatureSize = (creatureSize-0.2)/10.0; //cool popping effect when reaches 10 x 10
  }
  PVector helperReaction(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    float modifiedSpeed = map(this.getSpirit(), 0, 100, 1, maxspeed);
    desired.mult(modifiedSpeed);  
    return desired;
  }
  void display() {
    stroke(0);
    strokeWeight(1);
    fill(r, g, b, 90); 
    //change size by velocity
    ellipse(location.x, location.y, creatureSize, creatureSize);
  }
  void checkEdges(Landscape l) {

    //width and height should depend on the center of the oce
    //add  width to PVector oceanCenter
    if (location.x > l.getCenterX() + float(l.getHeight())) {
      velocity.x *= -0.3;
      location.x = float(l.getHeight()) + l.getCenterX(); //float(l.getHeight())
    }  
    else if (location.x < l.getCenterX() + float(l.getHeight()) && location.x < l.getCenterX() ) {
      velocity.x *= -0.3;
      location.x = l.getCenterX();
    }
    if (location.y > (float(l.getWidth()) + l.getCenterY())) {
      velocity.y *= -1;
      location.y = float(l.getWidth()) + l.getCenterY();
    }
    else if (location.y < (float(l.getWidth()) - l.getCenterY()) && location.y < l.getCenterY()) {      
      velocity.y *= -1;
      location.y = l.getCenterY();
    }
  }

  float getSpirit() {
    return spirit;
  }
  void setSpirit(float s) {
    spirit = s;
  }
  Landscape getMoverLandscape() {
    return l;
  }
  void setMoverLandscape(Landscape _l) {
    this.l = _l;
  }
  PVector getLocation() {
    return location;
  }
  void setColor(int _r, int _g, int _b) {
    r = _r;
    g = _g;
    b = _b;
  }
}

