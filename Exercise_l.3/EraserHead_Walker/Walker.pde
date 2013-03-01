// Tweak: Maya Richman

// The Nature of Code
// Original: Daniel Shiffman
// http://natureofcode.com

// A random walker class!

class Walker {
  float x, y;
  float prob, vx, vy;
  Gauge g;

  Walker() {
    x = width/2;
    y = height/2;
    prob = 0.1;
  }

  void draw() {
    noStroke();
    fill(255, 20);
    ellipse(x, y, 30, 30);   // Draw an ellipse at our "normal" random location
  }

  void walk() {
    g = new Gauge(prob); //construct new gauge with new probability
    g.draw();
    float randomNumber = (float)random(1);
    if (randomNumber < prob) {
      if (mouseY < 250 && mouseX < 250) {  //move to corners based off of the X and Y of the mouse    
        vx--;
        vy--;
      }
      else if (mouseY <= 250 && mouseX >= 250) {
        vy--;
        vx++;
      }
      else if (mouseY >= 250 && mouseX >= 250) {  
        vy++;
        vx++;
      } 
      else if (mouseY >= 250 && mouseX <= 250) {  
        vx--;
        vy++;
      }
    }
    else { //if random number is greater than the prob, randomly move 
      vx = random(-5, 5);
      vy = random(-5, 5);
    }
    x += vx;
    y += vy;

    // Stay on the screen
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
  }
}

