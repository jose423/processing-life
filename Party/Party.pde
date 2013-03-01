//motion types
/*
random
 gaussian
 perlin noise
 custom probability
 */

class Party {
  String dance;
  float xoff, yoff;
  float increment = 0.1;

  Party(String movement, float xoff, float yoff) { 
    dance = movement;
    xoff = xoff;
    yoff = yoff;
  } 

  void draw() {

    if (dance == "Perlin") {
      noisyParty();
    }
    if (dance == "Random") {
      randomParty();
    }
  }
  void randomParty() {
    smooth();
    fill(0, 100, 100);
    ellipse(random(500),random(500), 30, 30);    
  }
  void noisyParty() {
    smooth();
    fill(100, 100, 100);
    float n = noise(xoff);
    println(n);
    ellipse(map(n, 0, 1, 0, 300), map(n, 0, 1, 0, 340), 30, 30);
    xoff = xoff + increment;
  }
}

