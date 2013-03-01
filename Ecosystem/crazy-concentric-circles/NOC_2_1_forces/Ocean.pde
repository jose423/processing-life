/*
This object represents a variable space that will change upon other factors with methods, i.e. wind and time of day
 
 The basic components of an ocean:
 size
 */

class Ocean {
  int oceanh, oceanw;
  PVector centerOcean;
  float directionFromMoon;
  int x = 1;
  Ocean(int w, int h) {
    centerOcean = new PVector(width/4, height/4);
    oceanw =  w;
    oceanh = h;
    directionFromMoon = 0.0;
  }

  void display() {
    fill(0, 100, 230);
    noStroke();
    rect(centerOcean.x, centerOcean.y, oceanh, oceanw);
    fill(0);
    rect(centerOcean.x, centerOcean.y, 10, 10);
  }

  void update() {
    fill(0, 100, 230);
    rect(centerOcean.x, centerOcean.y, oceanh, oceanw);
    fill(0);
    rect(centerOcean.x, centerOcean.y, 10, 10);

    directionFromMoon++;
    directionFromMoon = directionFromMoon%360;
  }
  //checks tide of ocean and moves accordingly, assumes moon is at 45degrees
  int checkTide(Moon m) {
    x++;
    //if high tide return 1
    if (directionFromMoon >= m.getDirection()*7 || directionFromMoon <= m.getDirection()*3) {
      centerOcean.div(1.001); //move toward moon
      return 1;
    }
    //if low tide return 0
    else if (directionFromMoon > m.getDirection()*3 || directionFromMoon < m.getDirection()*7) {
      centerOcean.mult(1.001); //move away from moon
      return 0;
    }
    return 0;
  }

  int getWidth() {
    return oceanw;
  }
  int getHeight() {
    return oceanh;
  }
  float getCenterX() {
    return centerOcean.x;
  }
  float getCenterY() {
    return centerOcean.y;
  }
}

