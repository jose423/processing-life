/*
This object represents a variable space that will change upon other factors with methods, i.e. wind and time of day
 
 The basic components of an ocean:
 size
 */
//give depth to ocean
class Ocean extends Landscape {
  PVector centerOcean;
  float directionFromMoon;
  int x = 1;
  int oceanh, oceanw;

  Ocean(int oceanw, int oceanh) {
    super(oceanw, oceanh);
    this.oceanw = oceanw;
    this.oceanh = oceanh;
    centerOcean = new PVector(width/5, 0,-10);
    directionFromMoon = 0.0;
  }

  void display() {
    fill(0, 100, 230);
    noStroke();
    
    rect(centerOcean.y, centerOcean.x, oceanh, oceanw);
  }

  void update() {
    fill(0, 100, 230,85);
    noStroke();
    
    rect(centerOcean.y, centerOcean.x, oceanh, oceanw); //reversed x and y to change direction of wave
    noFill();
    stroke(1);
//    translate(centerOcean.x, centerOcean.y);
//    box(oceanw);

    directionFromMoon++;
    directionFromMoon = directionFromMoon%720;
  }
  //checks tide of ocean and moves accordingly, assumes moon is at 45degrees
  boolean checkTide(Moon m) {
    //if high tide return 1
    if (directionFromMoon >= m.getDirection()*14 || directionFromMoon <= m.getDirection()*6) { //equal parts moving toward moon 
      return true;
    }
    else {     //if low tide return 0
      if (directionFromMoon > m.getDirection()*6 || directionFromMoon < m.getDirection()*14) {
        return false;
      }
      return false;
    }
  }
  void updateTide(Moon m){
    x++;
    //if high tide return 1
    if (directionFromMoon >= m.getDirection()*14 || directionFromMoon <= m.getDirection()*6) { //equal parts moving toward moon 
      centerOcean.div(1.001); //move toward moon
    }
    else {     //if low tide return 0
      if (directionFromMoon > m.getDirection()*6 || directionFromMoon < m.getDirection()*14) {
        centerOcean.mult(1.001); //move away from moon
      }
    }    
  }
  float getCenterX() {
    return centerOcean.y;
  }
  float getCenterY() {
    return centerOcean.x;
  }
}

