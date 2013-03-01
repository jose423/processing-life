class Gauge {
  float colorprob;
  
  Gauge(float prob) {
    //rectangle with 10 circles in it
    colorprob = prob;
  }

  void draw() {
    smooth();
    fill(248,214,224,20);
    rect(10, 10, 100, 10);
    int i = 15;
    for (int c = 0; c < (colorprob*10); c++) {
      smooth(); //show red dot for every increase in probability to follow mouse
      fill(106, 17, 42);
      ellipse(i, 15, 6, 6);
      i = i + 10;
    }
  }
}

