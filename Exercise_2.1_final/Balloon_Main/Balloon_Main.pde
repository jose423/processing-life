/**
Author: Maya Richman
Title: 99 Red Balloons
Date: February 20,2013
Using forces, simulates a helium-filled balloon floating upward
and bouncing off the top of a window with variable wind according to Perlin noise. 
**/

Balloon hell;
PVector wind, gravity;
//seed value for noise for wind force
float xoff = 0.0;

//construct array list of balloon objects
ArrayList<Balloon> helloBalloons = new ArrayList<Balloon>();

void setup() {
  size(1000, 500);
  background(0);
  //inital wind force
  wind = new PVector(0.001, 0);
  //set gravity for entire sketch
  gravity = new PVector(0, -0.1);
}

void draw() {
  background(0);
  //set wind with new noise value
  windChanges();

  //update all balloons in arraylist
  for (Balloon balloon: helloBalloons) {
    balloon.update();
    //if check edges returns true, balloon has passed the width of the sketch, so remove it
    if (balloon.checkEdges()) {
      helloBalloons.remove(balloon);   
      break;
    }
    balloon.display(); //show balloon
    balloon.applyForce(gravity); //apply gravity to all balloons
    balloon.applyForce(wind); //apply wind value
  }
}
//when mouse is clicked make new Balloon object and add to arraylist helloBalloons
void mouseClicked() { //construct new ballon added to arraylist where clicked
  helloBalloons.add(new Balloon(mouseX));
}
void mouseDragged() {
    helloBalloons.add(new Balloon(mouseX));
}

void windChanges() {
  float windChange = noise(xoff); //get noise value from seed
  xoff = xoff + 0.01;
  wind.set(windChange*0.03, 0.0, 0.0); //set wind to this value that will be applied in draw
}

