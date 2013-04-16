/**
 
 This class creates a FrictionStructure object which is a collection of FrictionSpaces with changing formations.
 
 **/
class FrictionStructure {

  ArrayList<FrictionSpace> landscapes = new ArrayList<FrictionSpace>();
  int randomSound;
  int n = 0;
  float frictionDecrease;
  float frictionIncrease;
  float c = 0.2;

  FrictionStructure() {
//    frictionDecrease = 3.5;
//    frictionIncrease = 1.0;
    frictionDecrease = 0;
    frictionIncrease = 0;
  }
  //what will change about the structure? Will it move?
  void update() {
  }
  //display FrictionSpaces that have been touched
  void display() {
    for (FrictionSpace landscape : landscapes) {
      if (landscape.bumped()) {
        landscape.displayTouched();
      }
      else {
        landscape.display();
      }
    }
  }
  //clear entire structure of FrictionSpaces
  void clearStructure() {
    landscapes.clear();
  }
  //Cycles through friction spaces and checks if current Creature falls within it
  void contains(Creature _c) {
    for (FrictionSpace landscape : structure.landscapes) {
      //if landscape contains a creature, play the random sound and lighten the background color value
      if (landscape.contains(_c)) { 
        //assign friction value of current space to Creature's forces
        _c.frictionValue = landscape.c;

/**trying to make rules about what sounds are called when
//        if (landscape.c == 0.0) {
//          randomSound = 1;
//        }
//        else {
//          randomSound = int(random(sampleList.size()/2, sampleList.size()));
//        }
**/     
        //map sound to level of friction
        randomSound = int(map(landscape.c,frictionDecrease,frictionIncrease,0,sampleList.size() - 1));
        
        //if landscape has been explored already don't make a sound
        if (!landscape.visitedBefore()) {
          //increment total explored space for Creature
          _c.exploredSpace();
          //play sound
          sampleList.get(randomSound).trigger();
          sampleList.get(randomSound).setGain(0.4);
          //make background lighter
          ground = ground + 1;
        }
      }
    }
  }
  //construct FrictionStructure landscape
  void makeStructure() {

    //limit what n can be to avoid moving too far off screen or make an edges method to scale within bounding box
    n = n%35;

    for (int i=0;i< random(40);i++) {

      //could make landscape objects long lines of conjoined squares instead of initializing them this way
      landscapes.add(new FrictionSpace(0+n, 70+n, 5, 5, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 100+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 130+n, 10, 10, frictionDecrease));

      landscapes.add(new FrictionSpace(0+n, 200+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 230+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(0+n, 260+n, 10, 10, frictionDecrease));

      landscapes.add(new FrictionSpace(70+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(100+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(130+n, 0+n, 10, 10, frictionDecrease));

      landscapes.add(new FrictionSpace(200+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(230+n, 0+n, 10, 10, frictionDecrease));
      landscapes.add(new FrictionSpace(260+n, 0+n, 10, 10, frictionDecrease));

      //--------------------------------------------------------------------

      landscapes.add(new FrictionSpace(width-n, height-70-n, 5, 5, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-100-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-130-n, 10, 10, frictionIncrease));

      landscapes.add(new FrictionSpace(width-n, height-200-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-230-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-n, height-260-n, 10, 10, frictionIncrease));

      landscapes.add(new FrictionSpace(width-70-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-100-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-130-n, height-0-n, 10, 10, frictionIncrease));

      landscapes.add(new FrictionSpace(width-200-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-230-n, height-0-n, 10, 10, frictionIncrease));
      landscapes.add(new FrictionSpace(width-260-n, height-0-n, 10, 10, frictionIncrease));
      n += 10;
      frictionIncrease++;
      frictionDecrease--;
    }
  }
}

