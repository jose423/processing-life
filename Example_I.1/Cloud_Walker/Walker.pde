/**
* Title: Walking Cloud
* Name: Maya Richman
* Date: January 14, 2013
* Assignment 1-a
**/

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker object!

class Walker {
  int x,y;

  Walker() {
    x = width/2;
    y = height/2;
  }

  void render() {
    stroke(255);
    point(x,y);
  }

  // Randomly move up, down, left, right, or stay in one place
  void step() {
    int choice = int(random(4));
    //randomly decrement or increment x or y
    if (choice == 0) {
      x++;
    } else if (choice == 1) {
      x--;
    } else if (choice == 2) {
      y++;
    } else {
      y--;
    }

   float prob = random(1);
   //each option is as likely and takes 4 steps more than the original
   if(prob < .25){
     x=x+5;
   }
   if(prob >= .25 && prob < .50){
     x=x-5; 
   }
   if(prob >= .50 && prob < .75){
     y=y+5; 
   }
   if(prob >= .75 && prob < 1){
     y=y-5; 
   }
   
    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
    
  }
}
