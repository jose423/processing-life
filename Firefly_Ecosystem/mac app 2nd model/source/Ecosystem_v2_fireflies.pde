import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

//Landscape
Ocean o;

//Contains multiple friction spaces (make more flexible in formation
FrictionStructure structure = new FrictionStructure();
float c;

// users will decide how large the ecosystem is
int numberMovers = 2 ; //default

//seeds for perlin movement
int seedx = 1;
int seedy = 10;

//holds all creatures who have explored no areas and have below 300 spirit
ArrayList<Creature>withoutSpirit = new ArrayList<Creature>();

//movements
Perlin_Movement movementPerlin;

//system that controls/organizes all creatures
CreatureSystem system;

//holds audio sample
ArrayList<AudioSample>sampleList = new ArrayList<AudioSample>();
Minim minim;
File path;
String[] sounds;
AudioSample wind, bootup;


//color of the background
float ground;


void setup() {
  size(700, 700);
  smooth();
  //set background color
  ground = 0;

  //sound setup
  minim = new Minim(this);
  path = new File("/Users/mayarichman/Documents/cart 353/Ecosystem_v2_fireflies/bit_coin_sounds");
  sounds = path.list();
  println(sounds);
  //fill array with sounds
  for (int j = 0; j < sounds.length;j++) {
    String song2 = "/bit_coin_sounds/" + sounds[j]; 
    AudioSample test = minim.loadSample(song2, 2048);   
    sampleList.add(test);
  }
  wind = minim.loadSample("winds.aif", 2048);
  bootup = minim.loadSample("bootup-ecosystem.aif", 2048);
  bootup.trigger();
  //build landscape structure
  structure.makeStructure();

  //construct ocean
  o = new Ocean(); 

  //construct movement for creature
  movementPerlin = new Perlin_Movement(random(100), random(200)); //construct default movement, I will make an original movement for each creature

  //initialize CreatureSystem
  system = new CreatureSystem(structure);

  //construct initial creatures and fill arraylist
  for (int i = 0; i < numberMovers; i++) {
    //assign perlin movement new values each time it enters loop
    movementPerlin = new Perlin_Movement(random(seedx), random(seedy)); 

    system.addCreature(movementPerlin, o);
    seedx += 1;
    seedy += 10;
  }
}
void draw() {
  background(ground);
  
  //update and display friction structure of friction spaces
  structure.update();
  structure.display();
  //display landscape and attractor
  o.display();

  //run creature system
  system.run();

  //update values in perlin movement
  movementPerlin.update();
}
void mousePressed() {
  o.setAttractor(new Attractor(mouseX, mouseY)); //add new attractor at mouse location, LATER: restrict where it can be placed?
}


void keyPressed() {
  //clear screen of landscapes and creatures and makes new landscapes
  if (key == CODED) {
    if (keyCode == LEFT) {
      wind.trigger();
      system.addWind("L");
    } 
    if (keyCode == RIGHT) {
      wind.trigger();
      system.addWind("R");
    }
  }
  if (key == 'c') {
    ground = 0;
    //remove movers
    system.clearSystem();
    //clear current landscape display
    structure.clearStructure();
    //build new landscape display, IDEA: variables keep adding or subtracting for location so "scene" changes
    structure.makeStructure();
    bootup.trigger();
  }
  //clears landscapes but leaves creatures without friction
  if (key == 'd') {
    //clear current landscape display
    structure.clearStructure();
    //clear friction so creatures move free
    system.clearFriction();
  }
  //add more creatures doesn't change or remove the landscape
  if (key == 'n') {
    for (int i = 0; i < numberMovers; i++) {
      //assign perlin movement new values each time it enters loop
      movementPerlin = new Perlin_Movement(random(seedx), random(seedy)); 
      //adds more creatures
      system.addCreature(movementPerlin, o);

      seedx += 1;
      seedy += 10;
    }
  }
  //move landscape but keep creatures
  if (key == 'm') {
    //clear friction so creatures move free
    structure.clearStructure();
    structure.makeStructure();
    system.clearFriction();
  }
}

