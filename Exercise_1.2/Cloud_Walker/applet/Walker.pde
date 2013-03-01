/**
* Title: Walking Cloud (w/ Vectors)
* Name: Maya Richman
* Date: January 14, 2013
* Assignment 2- Chapter 1-2 Exercise
**/
// Original by:
// Daniel Shiffman
// http://natureofcode.com

// A random walker object!


class Walker {
  PVector location;
  int step; //can this be part of a new pvector class


  Walker() {
    location = new PVector(width/2,height/2);
    step = 5;
  }

  void render() {
    stroke(255);
    point(location.x,location.y);
  }

  // Randomly move up, down, left, right, or stay in one place
  void step() {
    int choice = int(random(4));
    //randomly decrement or increment x or y
    if (choice == 0) {
      location.x++;
    } else if (choice == 1) {
      location.x--;
    } else if (choice == 2) {
      location.y++;
    } else {
      location.y--;
    }

   float prob = random(1);
   //each option is as likely and takes 4 steps more than the original
   if(prob < .25){
     location.x=location.x+step;
   }
   if(prob >= .25 && prob < .50){
     location.x=location.x-step; 
   }
   if(prob >= .50 && prob < .75){
     location.y=location.y+step; 
   }
   if(prob >= .75 && prob < 1){
     location.y=location.y-step; 
   }
   
    location.x = constrain(location.x,0,width-1);
    location.y = constrain(location.y,0,height-1);
    
  }
}
