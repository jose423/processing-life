/**
* Author: Maya Richman 
* Title: Three Dee Perlin Worms
* Date: March 1, 2013
* Original: Daniel Shiffman
**/

class Mover {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;
  float seedx;
  float seedy;
  float x = 0.0;
  float y = 0.0;
  float seedColor = 2000;
  Mover(int _w, int _h, int _x, int _y) {
    // Start in the center
    location = new PVector(_w, _h);
    velocity = new PVector(0, 0);
    topspeed = 2;
    acceleration = new PVector(0, 0);
    seedx = _x;
    seedy = _y;
  }

  void update() {

    acceleration.normalize();

    float accelerationNoiseX = noise(seedx);
    float accelerationNoiseY = noise(seedy);
    x = map(accelerationNoiseX, 0, 1, -1, 1);
    y = map(accelerationNoiseY, 0, 1, -1, 1);
    seedx =  seedx + 0.1;
    seedy = seedy + 0.1;

    acceleration.x = x;
    acceleration.y = y;

    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);

    // Stay on the screen
    location.x = constrain(location.x, 0, width-1);
    location.y = constrain(location.y, 0, height-1);
    seedColor = seedColor + 10;
  }

  void display() {
    stroke(noise(seedx)*255, noise(seedy)*255, noise(seedy)*255, 60);
    strokeWeight(10);
    line(location.x, location.y, location.x, location.y);

    stroke(noise(seedx)*255, 20);
    strokeWeight(10);
    line(location.x-10, location.y-10, location.x, location.y);
  }
}

