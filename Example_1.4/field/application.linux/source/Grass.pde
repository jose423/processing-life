/**
 * Title: Grass
 * Author: Maya Richman
 * Date: Februrary 3, 2013
 **/

class Grass {

  float noise2 = 0.1; //starting point for noise
  PVector root, growth;
  //difference "center" based on constructor, same multiplying effect
  Grass(float x_, float y_) {
    growth = new PVector(600, 350);
    root = new PVector(x_, y_);
  }

  void draw() {

    PVector growth = new PVector(mouseX, mouseY);
    growth.sub(root);//subtract from root depending on each grass object made
    growth.mult(1.3); //static for now

    strokeWeight(1);
    stroke(10, random(200*noise(90), 200*noise(mouseY)), 0);
    line(0, 0, growth.x, growth.y); //draw remainder between subtraction from each root plus 1.3 times the length
  }
  //increases/decreases noise dependent on location of mouse
  void increaseNoise(float mouse) { 
    noise2 = (0.01)*abs(mouse - height);
    noiseDetail(20, noise2);
  }
  void decreaseNoise(float mouse) {
    noise2 = (0.01)*(mouse - height);
    noiseDetail(20, noise2);
  }
}

