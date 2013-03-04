/**
 * Author: Maya Richman
 * Date: March 1, 2013
 * Title: Pinball Wizard Movers
 * Original Code from Daniel Shiffman
 **/

// It would be cool to control wind by arrow keys
// to guide movers to hit all landscapes then they win!


PFont hell;
ArrayList<Mover> movers = new ArrayList<Mover>();
ArrayList<Landscape> landscapes = new ArrayList<Landscape>();
List<Landscape> landscapesSync = Collections.synchronizedList(landscapes);
float c = 0.2;
int i = 1;
int n = 0;
float frictionDecrease = 3.0;
float frictionIncrease = 0.1;
int totalMovers = 40;
int opacity = 150;


void setup() {
  size(600, 700, OPENGL);
  
  //create font
  hell = createFont("Helvetica-Light", 18); //create Helvetica font
  randomSeed(1);
  hint(ENABLE_NATIVE_FONTS); 
  
  //add totalMovers to arraylist movers each at random locations along the top of the sketch
  for (int i=0;i<totalMovers;i++) {
    movers.add(new Mover(random(1, 4), random(width), 0));
  }
  //construct all landscapes objects (colored squares with different frictions
  makeLandscapes();
}

void draw() {
  background(0);

  //  cycle through landscapesSync and display
  for (Landscape landscape : landscapesSync) {
    landscape.display();
    if (landscape.bumped()) {
      landscape.touched();
    }
  }
  // cycle through movers and apply gravity based on mass
  for (Mover mover : movers) {
    PVector wind = new PVector(0.01, 0);
    PVector gravity = new PVector(0, 0.1*mover.mass);

    c = 0.05;

    //does landscape contain mover?
    for (Landscape landscape : landscapesSync) {
      if (landscape != null) {
        if (landscape.contains(mover)) { //contains checks the boundaries that the landscape has
          c = landscape.c;
          landscape.update(); //turn blue if landscape contains mover
        }
      }
    }

    PVector friction = mover.velocity.get(); //apply friction based off of landscape
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);
    
    //apply all forces
    mover.applyForce(friction);
    mover.applyForce(wind);
    mover.applyForce(gravity);

    mover.update();
    mover.display();

    //text display to explain click function
    textAlign(CENTER, CENTER);
    textFont(hell);
    textSize(18);
    fill(255, opacity);
    text("Click mouse to make more pinballs", width/2, height/2); 
    
    //check edges and remove the mover from the arraylist if it has fallen off the screen
    if (mover.checkEdges()) {
      movers.remove(mover);
      break;
    }
  }
}
//method makes constructs all landscapes
void makeLandscapes() {

  //limit what n can be to avoid moving too far off screen or make an edges method to scale within bounding box
  n = n%35;
  frictionIncrease = 0.1;
  frictionDecrease = 3.0;

  for (int i=0;i<20;i++) {

    //could make landscape objects long lines of conjoined squares instead of initializing them this way
    landscapesSync.add(new Landscape(0+n, 70+n, 5, 5, frictionDecrease));
    landscapesSync.add(new Landscape(0+n, 100+n, 10, 10, frictionDecrease));
    landscapesSync.add(new Landscape(0+n, 130+n, 10, 10, frictionDecrease));

    landscapesSync.add(new Landscape(0+n, 200+n, 10, 10, frictionDecrease));
    landscapesSync.add(new Landscape(0+n, 230+n, 10, 10, frictionDecrease));
    landscapesSync.add(new Landscape(0+n, 260+n, 10, 10, frictionDecrease));

    landscapesSync.add(new Landscape(70+n, 0+n, 10, 10, frictionDecrease));
    landscapesSync.add(new Landscape(100+n, 0+n, 10, 10, frictionDecrease));
    landscapesSync.add(new Landscape(130+n, 0+n, 10, 10, frictionDecrease));

    landscapesSync.add(new Landscape(200+n, 0+n, 10, 10, frictionDecrease));
    landscapesSync.add(new Landscape(230+n, 0+n, 10, 10, frictionDecrease));
    landscapesSync.add(new Landscape(260+n, 0+n, 10, 10, frictionDecrease));

    //--------------------------------------------------------------------

    landscapesSync.add(new Landscape(width-n, height-70-n, 5, 5, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-100-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-130-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-n, height-200-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-230-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-n, height-260-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-70-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-100-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-130-n, height-0-n, 10, 10, frictionIncrease));

    landscapesSync.add(new Landscape(width-200-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-230-n, height-0-n, 10, 10, frictionIncrease));
    landscapesSync.add(new Landscape(width-260-n, height-0-n, 10, 10, frictionIncrease));
    n += 10;
    frictionIncrease++;
    frictionDecrease--;
  }
}
//construct all new movers and add to the array
void mouseClicked() {
  for (int i=0;i<totalMovers;i++) {
    movers.add(new Mover(random(1, 4), random(width), 0));
  }
  opacity -= 25; //decrement opacity of text directions

  //after some amount of clicks, set boolean bumped to false to all squares? or set key clear to clear all movers and reset colors of friction points
}

void keyPressed() {
  //clear screen of landscapes and movers
  if (key == 'c') {
    movers.clear(); //clear all movers
    landscapesSync.clear(); //clear current landscape display
    //variables keep adding or subtracting for location so "scene" changes, update landscape display
    makeLandscapes();
  }
}

