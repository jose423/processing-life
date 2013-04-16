/**
 
 This class creates a FrictionStructure object which is a collection of FrictionSpaces with changing formations. This class is
 responsible for triggering visual changes and sounds from the FrictionSpaces.
 
 **/
class FrictionStructure {

  ArrayList<FrictionSpace> landscapes = new ArrayList<FrictionSpace>(); //holds FrictionSpaces
  int n = 0; //limits the structures extent on sketch
  float frictionDecrease; //to increase and decrease friction values
  float frictionIncrease;
  boolean randomizeSound; //determines whether sound corresponds with friction values or randomized to be in the higher octaves

  FrictionStructure() {
    frictionDecrease = 0;
    frictionIncrease = 0;
    randomizeSound = false; //default is mapped to friction
  }
  void update() {    
    for (FrictionSpace landscape : landscapes) {
      if (landscape.bumped()) {
        landscape.update();
      }
    }
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

          //map sound to level of friction
          sound = soundPreference(landscape);


          //if landscape has been explored already don't make a sound
          if (!landscape.visitedBefore()) {
            //increment total explored space for Creature
            _c.exploredSpace();
            //play sound
            sampleList.get(sound).trigger();
            sampleList.get(sound).setGain(0.4);
            //make background lighter
            ground = ground + 1;
          }
        }
      }
    }
    //set sound preference with current value of randomizeSound
    int soundPreference(FrictionSpace f) {
      if (randomizeSound) {
        //use higher register sounds only
        return int(random(sampleList.size()/2, sampleList.size() - 1));
      }
      else {
        //map sounds to friction values on FrictionStructure
        return int(map(f.c, frictionDecrease, frictionIncrease, 0, sampleList.size() - 1));
      }
    }
    //trigger change in sound profile
    void changeSoundProfile() {
      if (randomizeSound) {
        randomizeSound = false;
      }
      else {
        randomizeSound = true;
      }
    }
    //construct FrictionStructure landscape
    void makeStructure() {

      //limit what n can be to avoid moving too far off screen or make an edges method to scale within bounding box
      n = n%35;
      
      //randomly changes total landscapes built between 0 and 40
      for (int i=0;i< random(40);i++) {

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

