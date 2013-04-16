/**
 
 This is the main Creature class. 
 A Creature can belong to a CreatureSystem. All forces acted upon Creatures within a CreatureSystem are updated here. Creatures explore the space belonging to a certian Landscape
 and have a certain Movement that determines the way they move around the Landscape. A Creature initially flickers randomly and moves around bumping into
 FrictionSpaces, part of FrictionStructure's making music and illuminating the background. Some Creatures are attracted to an Attractor object that is moved by the user. As Creatures
 explore, they build halos of illumination that show them what structures are around them that they have not hit. They get also begin to fade and die in the CreatureSystem.
 
 **/
class Creature {
  Movement m;   //movement associated with creature
  Landscape l;   //landscape associated with creature
  PVector location, velocity, acceleration, attracted, curiosity, wind, gravity;
  int maxSpeed, maxForce;   //set max speed for velocity
  float lifeforce, frictionValue; //friction applied from environment onto Creature, lifeforce sents length of time on screen
  float size; //dictates flucauating creature size
  boolean blink; //dictates flashing pattern
  float opacity; //opacity of creature, changes with lifeforce
  Random generator = new Random();
  float gaus = (float) generator.nextGaussian();

  float MAXLIFESPAN = 3000;   //set maximum life span for any one creature
  int halo = 255;   //starting halo opacity value for flickering

  float spirit; //spirit determines how quickly Creature follows the hand
  float sdSpirit = 25;   // Define a standard deviation
  float meanSpirit = 500;   // Define a mean value 

  float gausColor; //flucuating yellow color by gaussian distribution
  float haloOpacity; //opacity for halo showing total spaces explored
  float sdColor = 100; //standard deviation for gaus color
  float meanColor = 200; //mean gaus color

  int totalSpacesExplored; //holds all spaces explored by each creature

  //Perlin_Movement movementPerlin = new Perlin_Movement(random(100), random(200));
  Random_Movement r = new Random_Movement();

  Creature(Landscape defaultL, float seedx, float seedy) {
    m = new Perlin_Movement(random(seedx), random(seedy)); //sets initial movement as random seeded perlin
    l = defaultL; //set initial landscape
    maxSpeed = 2; //set max speed
    maxForce = 2; //set max force
    location = new PVector(random(l.getWidth()), random(l.getHeight())); //choose random location within bounds of_l
    velocity = new PVector(0, 0); //determines rate of movement
    acceleration = new PVector(0, 0); //changes velocity, or rate of movement which changes location (bigger steps)
    wind = new PVector(0, 0); //empty wind force
    gravity = new PVector(0, 0); //empty gravity force
    attracted = l.getAttractorLocation(); //set attractor to landscape-default
    lifeforce = MAXLIFESPAN; //set all lifeforce to max
    frictionValue = 0; //default 0 friction
    spirit = ( gaus * sdSpirit ) + meanSpirit; //gaussian distribution of spirit
    totalSpacesExplored = 0; //default spaces explored to 0
    blink = true;
    haloOpacity = 50; //default halo opacity
  }
  void update() {
    //update values in Movement
    m.update();
    //apply movement associated with current creature
    applyForce(m.applyMovement()); 

    //apply wind force
    applyForce(wind);

    //apply friction
    PVector friction = velocity;
    friction.mult(-1); 
    friction.normalize();
    friction.mult(frictionValue);
    applyForce(friction);

    // only apply attraction if spirit is below 300, otherwise decrement spirit, IDEA: some creatures should never move toward the attractor
    if (spirit < 300) {

      //get the current location of the attractor for landscape
      attracted = l.getAttractorLocation(); 

      PVector desired = PVector.sub(attracted, location);   // Calculate direction of force

      //steer Creatures towards the Attractor otherwise repel Creatures from Attractor object
      if (l.isAttractor()) {
        desired.normalize();
        desired.mult(maxSpeed);
        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
        applyForce(steer);
      }
      else {
        desired.normalize();                           // Normalize vector (distance doesn't matter here, we just want this vector for direction)
        float d = desired.mag();                       // Distance between objects
        d = constrain(d, 5, 100);                    // Keep distance within a reasonable range
        float force = -1 * G / (d * d);            // Repelling force is inversely proportional to distance
        desired.mult(force);                           // Get force vector --> magnitude * direction
        applyForce(desired);
      }
      spirit--;
    }
    else { 
      // Idea: apply some acceleration based on total squares explored that have been touched
      // by each creature or willingness to not be attracted as related to total spaces explored
      // curiousity points to the bottom right, IDEA: Make fireflies more likely explore unexplored 
      // areas with more spirit and more places explored
      spirit--;
    }

    //Idea: assign gravity if close to death
    //    if (lifeforce < 200) {
    //      gravity = new PVector(0, 20.0);
    //    }

    //apply gravity
    applyForce(gravity); 

    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);

    //decrease lifeforce
    lifeforce = lifeforce - 2;
  }
  void display() {

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
      //other option of size
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

    //map lifeforce to opacity to fade when they get older and die :(
    opacity = map(lifeforce, 0, MAXLIFESPAN, 0, 255);
    stroke(255, 255, 200, opacity);
    strokeWeight(2);
    fill(255, 255, 100, opacity);
    ellipse(location.x, location.y, size, size);

    //flicker halo between white and black
    if (halo == 255) {
      halo = 0;
    }
    else {
      halo = 255;
    }
    fill(halo, haloOpacity);
    stroke(1);
    //make stroke color change with a gaussian pattern
    stroke(255, 255, gausColor, opacity);
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
  //apply wind force for a Creature
  void setWindForce(PVector _wind) {
    wind = _wind;
  }
}

