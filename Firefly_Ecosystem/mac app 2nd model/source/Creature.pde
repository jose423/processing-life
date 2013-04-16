/**
 
 This is the main Creature class. 
 A Creature can belong to a CreatureSystem. All forces acted upon Creatures within a CreatureSystem are updated here. Creatures explore the space belonging to a certian Landscape
 and have a certain Movement that determines the way they move around the Landscape. A Creature initially flickers randomly and moves around bumping into
 FrictionSpaces, part of FrictionStructure's making music and illuminating the background. Some Creatures are attracted to an Attractor object that is moved by the user. As Creatures
 explore, they build halos of illumination that show them what structures are around them that they have not hit. They get also begin to fade and die in the CreatureSystem.
 
 **/
class Creature {
  //movement associated with creature
  Movement m; 
  //landscape associated with creature
  Landscape l; 
  PVector location, velocity, acceleration, resistance, attracted, curiosity;
  //set max speed for velocity
  int maxSpeed, maxForce; 
  float lifeforce;
  float frictionValue;
  float MAXLIFESPAN = 3000;
  float size;
  boolean blink;

  Random generator = new Random();
  float gaus = (float) generator.nextGaussian();

  float spirit;
  float sdSpirit = 25;   // Define a standard deviation
  float meanSpirit = 500;   // Define a mean value 
  
  float gausColor;
  float sdColor = 55;
  float meanColor = 200;

  int totalSpacesExplored;

  Creature(Movement defaultM, Landscape defaultL) {
    m = defaultM; //set initial movement
    l = defaultL; //set initial landscape
    maxSpeed = 2; //set max speed
    maxForce = 2;
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps)
    resistance = new PVector(0, 0);
    curiosity = new PVector(0.001, 0.001);
    attracted = l.getAttractor().location; //set attractor to landscape-default
    lifeforce = MAXLIFESPAN;
    frictionValue = 0;
    spirit = ( gaus * sdSpirit ) + meanSpirit;
    totalSpacesExplored = 0;
    blink = true;
  }
  Creature(Movement defaultM) {
    m = defaultM; //set initial movement
    l = new Landscape(); //set initial landscape
    maxSpeed = 1; //set max speed
    maxForce = 2;
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps)
    resistance = new PVector(0, 0);
    curiosity = new PVector(0.001, 0.001);
    attracted = l.getAttractor().location; //set attractor to landscape-default
    lifeforce = 255;
    frictionValue = 0;
    spirit = ( gaus * sdSpirit ) + meanSpirit;
    totalSpacesExplored = 0;
    blink = true;
  }

  void update() {

    //apply friction
    PVector friction = velocity;
    friction.mult(-1); 
    friction.normalize();
    friction.mult(frictionValue);
    println(friction);
    applyForce(friction);


    // only apply attraction if spirit is below 300 and without exposure to other places, otherwise decrement spirit (and apply curiousity force) IDEA: some creatures should never move toward the attractor
    if (spirit < 300) { // && totalSpacesExplored == 0 is this problematic? What if spirit is less than 300 and previously 0 places were explored but now one is, will the attracted location be wrong?

/** Debugging      
//      if(!withoutSpirit.contains(this)){
//        withoutSpirit.add(this);
//      }
**/
      attracted = l.getAttractor().location; //get the current location of the attractor for landscape
      PVector desired = PVector.sub(attracted, location); //target is the attracted creatures or inanimate attracted objects location
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxForce);
      applyForce(steer);
    }
    else { //apply some acceleration based on total squares explored that have been touched by each creature or willingness to not be attracted as related to total spaces explored
      //curiousity points to the bottom right, IDEA: Make fireflies more likely explore unexplored areas with more spirit and more places explored
      //      applyForce(curiosity);
      
      /** Really cool shape, too computationally taxing
      //      float angle = 0;
      //      float angleVel = 0.2;
      //      float amplitude = 10;
      //      beginShape();
      //      stroke(0, 255, gausColor);
      //      for (int x = 0; x <= location.x; x += 5) {
      //        float y = map(sin(angle), -1, 1, 0, location.y);
      //        vertex(x, y);//      With beginShape() and endShape(), you call vertex() to set all the vertices of your shape.
      //        angle +=angleVel;
      //      }
      //      endShape();
      **/
      PVector randomDirection = new PVector(random(-1.0,1.0),random(-1.0,1.0));
      applyForce(randomDirection);
      spirit--;
    }

    //apply movement associated with current creature
    applyForce(m.applyMovement()); 

    //all creatures apply resistance
    applyForce(resistance); 

    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);

    //decrease lifeforce
    lifeforce = lifeforce - 2;
  }
  void display() {
    /**
     Alt design
     fill(255, opacity);
     ellipse(location.x + 2, location.y - 5, 5, 5);
     fill(200, 200, 20, opacity);
     ellipse(location.x, location.y, random(5, 20), 10);
     **/

    /**size is randomized, make it syncronized over time, 
     change from random to gaussian to absolute values, iterate through an array that has 1 through 12, randomly iterate though it to determine size, then at some point
     maybe when lifeforce is at a certain level, start limiting the options of randomness
     **/

    //size of firefly creature determined by random generator for un-patterned flickering effect
    float randomSize = random(12);

    //calculate size in a gaussian distribution for more ordered flickering effect
    gaus = (float) generator.nextGaussian();
    float sdSize = 4;
    float meanSize = 6;
    float gausSize = ( gaus * sdSize ) + meanSize;

    //calcluate gaussiacolor for firefly halos
    gaus = (float) generator.nextGaussian();
    gausColor = ( gaus * sdColor ) + meanColor;

    //if spirit is greater than 300 use random flickering pattern, otherwise occilate between size 6 and 15 for a standardized flicker simulating emergence
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
        size = 10;
        blink = true;
      }
    }

    //map lifeforce to opacity to fade when they get older and die :(
    float opacity = map(lifeforce, 0, MAXLIFESPAN, 0, 255);
    stroke(255, 255, 200, opacity);
    strokeWeight(2);
    fill(255, 255, 100, opacity);
    ellipse(location.x, location.y, size, size);

    fill(255, 10);
    //make stroke color change with a gaussian pattern
    stroke(255, gausColor, gausColor, opacity);
    //halo showing how much exploration and enlightment the creatures have
    ellipse(location.x, location.y, size + totalSpacesExplored*4, size + totalSpacesExplored*4);
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  //if lifeforce is 0 then the firefly is dead
  boolean isDead() {
    return lifeforce == 0;
  }
  // assign Creature with particular movement (i.e. Perlin, Random)
  void setMovement(Movement _m) {
    m = _m;
  }
  // returns the current movement applied to the Creature
  Movement getMovement() {
    return m;
  }
  // assign Creature with particular Landcape (movement bounds)
  void setLandscape(Landscape _l) {
    l = _l;
  }
  // returns the current landscape (movement bounds) applied to the Creature
  Landscape getLandscape() {
    return l;
  }
  //return attracted force as PVector 
  PVector getAttractorForce() { 
    return attracted;
  }
  //set attractor force for landscape's attractor
  void setAttractorForce(PVector _attracted) { 
    attracted = _attracted;
  }
  //set the friction value applied to the acceleration to 0
  void clearFriction() {
    frictionValue = 0;
  }
  //increment the spaces explored by the particular creature
  void exploredSpace() {
    totalSpacesExplored++;
  }
}

