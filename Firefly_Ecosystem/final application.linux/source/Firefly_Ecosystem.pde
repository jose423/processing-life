/**
Name: Maya Richman
Title: Emerging Symphonies: Fireflies & Musical Landscapes
Date: April 16, 2013

**/
//load audio libraries
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

//Landscape
Sky s;

//Lantern
Lantern lanternFull;
Light lightSource;

//keeps track of sky's attractor status
boolean isAttractor = true;

//Contains multiple friction spaces (make more flexible in formation
FrictionStructure structure = new FrictionStructure();

// users will decide how large the ecosystem is
int numberMovers = 3 ; //default

//holds all creatures who have explored no areas and have below 300 spirit
ArrayList<Creature>withoutSpirit = new ArrayList<Creature>();

//system that controls/organizes all creatures
CreatureSystem system;

//system that holds ocillators
CreatureSystem ocillators;

//holds audio sample
ArrayList<AudioSample>sampleList = new ArrayList<AudioSample>();
Minim minim;
File path;
String[] sounds;
AudioSample wind, bootup, buzz;
int sound;

//color of the background
float ground;

void setup() {
  size(900, 700);
  smooth();

  //set background color
  ground = 0;

  //sound setup
  minim = new Minim(this);
  path = new File("/Users/mayarichman/Documents/cart 353/Firefly_Ecosystem/bit_coin_sounds");
  sounds = path.list();

  //fill array with sounds for FrictionSpaces
  for (int j = 0; j < sounds.length;j++) {
    String song2 = "/bit_coin_sounds/" + sounds[j]; 
    AudioSample test = minim.loadSample(song2, 2048);   
    sampleList.add(test);
  }  
  //assign sounds for wind, changed by left and right arrows
  wind = minim.loadSample("winds.aif", 2048);
  //assign sounds for "bootup" ecosystem
  bootup = minim.loadSample("bootup-ecosystem.aif", 2048);
  bootup.trigger();

  buzz = minim.loadSample("buzzing-loud.mp3", 2048);

  //build Lantern
  lanternFull = new Lantern(width/2, 0, 100);
  lightSource = new Light(width/2, 100);

  //build landscape structure
  structure.makeStructure();

  //construct Sky with an Attractor
  s = new Sky(); 

  //initialize CreatureSystem
  system = new CreatureSystem(structure);
  ocillators = new CreatureSystem(structure);

  //construct initial creatures and fill arraylist
  for (int i = 0; i < numberMovers; i++) {
    system.addCreature(s);
  }
}
void draw() {
  background(ground);
  //connect latern to Light and constrain length
  lanternFull.connect(lightSource);
  lanternFull.constrainLength(lightSource, 40, height);

  //update Light and check if dragged
  lightSource.update();
  lightSource.drag(mouseX, mouseY);

  //display rope between the Lantern and top of the screen, lantern and light
  lanternFull.displayLine(lightSource);
  lightSource.display();
  lanternFull.display();

  //if either CreatureSystem has hit the light remove them from the system
  system.hitLight(lightSource);
  ocillators.hitLight(lightSource);

  //update and display friction structure of friction spaces
  structure.update();
  structure.display();

  //display landscape and attractor
  s.display();

  //run creature systems
  system.run();
  ocillators.run();

}
//move attractor
void mousePressed() {
  //check if light was clicked
  lightSource.clicked(mouseX, mouseY);
  //add new attractor at mouse location, LATER: restrict where it can be placed?
  s.setAttractor(new Attractor(mouseX, mouseY)); 
  //trigger noise for new occilators
  buzz.trigger();
  for (int i = 0; i < numberMovers; i++) {
    //adds more creatures
    ocillators.addOscillator(s, mouseX, mouseY);
  }
}
void mouseReleased() {
  //stop dragging the lantern
  lightSource.stopDragging();
}
void keyPressed() {
  if (key == CODED) {
    //add wind to system from left
    if (keyCode == LEFT) {
      wind.trigger();
      system.addWind("L");
    } 
    //add wind to system from right
    if (keyCode == RIGHT) {
      wind.trigger();
      system.addWind("R");
    }
    //stop the wind
    if (keyCode == SHIFT) {
      system.addWind("Stop");
    }
    //increment the number of movers created when 'n' is pressed by 1
    if (keyCode == UP) {
      if (numberMovers!= 30) {
        numberMovers++;
      }
    } 
    //decrement the number of movers created when 'n' is pressed by 1
    if (keyCode == DOWN) {
      if (numberMovers > 0) {
        numberMovers--;
      }
    }
  }
  //clear the screen, start from begin
  if (key == 'c') {
    ground = 0;
    //remove movers
    system.clearSystem();
    ocillators.clearSystem();
    //clear current landscape display
    structure.clearStructure();
    //build new landscape display, IDEA: variables keep adding or subtracting for location so "scene" changes
    structure.makeStructure();
    //trigger construction sound
    bootup.trigger();
    for (int i = 0; i < numberMovers; i++) {
      //adds more creatures
      system.addCreature(s);
    }
  }
  //clears landscapes but leaves creatures without friction
  if (key == 'f') {
    //clear current landscape display
    structure.clearStructure();
    //clear friction so creatures move free
    system.clearFriction();
  }
  //add more creatures doesn't change or remove the landscape
  if (key == 'n') {
    for (int i = 0; i < numberMovers; i++) {
      //adds more creatures
      system.addCreature(s);
    }
  }
  //move landscape but keep creatures
  if (key == 'm') {
    //clear friction so creatures move free
    structure.clearStructure();
    structure.makeStructure();
    system.clearFriction();
  }
  //randomize or organize sounds
  if (key == 's') {
    structure.changeSoundProfile();
  }
  //reverses effect of attractor, makes into a repeller, vice versa
  if (key == 'r') {
    s.reverseAttractor();
  }
}

