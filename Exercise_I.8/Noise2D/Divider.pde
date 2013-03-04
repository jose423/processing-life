class Divider {
  PVector location, speed;
  int dwidth = 10;
 

  Divider(float x_, float y_, float xspeed, float yspeed) {
    location = new PVector(x_, y_);
    speed = new PVector(xspeed, yspeed);
  }

  void draw() {
    fill(235, 245, 47); 
    noStroke();
    rect(location.x, location.y, dwidth, dheight);
    run();
  }

  //make method that moves yellow rectange PVector
  void run() {

    location.add(speed);
  }

  boolean checkLocation() {
    if ((location.y > height)){// || (location.y < 0)) {
      //location.y = -dwidth/2;
      return true;
    }
    else { 
      return false;
    }
  }
}

