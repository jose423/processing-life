class Noise {

  float increment;
  int noiseDetailVar1;
  float noiseDetailVar2;//0.45;
  float zoff;
  float xoff;
  Divider d1, d2, d3, d4;
  float center = 400;

  Noise(float i_, int o_, float fallout_, float z_, float x_ ) {
    increment = i_;//0.1;
    noiseDetailVar1 = o_;//3;
    noiseDetailVar2 = fallout_;//0.20;
    zoff = z_;//0.0;
    xoff = x_;//0.0;

    //avoid hard coding values, instead in for loop call all dividers in divider array with move method
    //    d1 = new Divider(center, 50,1.0,2.0);
    //    d2 = new Divider(center, 175);
    //    d3 = new Divider(center, 300);
    //    d4 = new Divider(center, -75);
  } 

  void draw() {
    background(255);
    loadPixels();

    // Start xoff at 0

    // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
    for (int x = 0; x < width; x++) {
      float yoff = 0.0;   // For every xoff, start yoff at 0
      for (int y = 0; y < height; y++) {
        yoff += 0.01; // Increment yoff

        // Calculate noise and scale by 255
        noiseDetail(noiseDetailVar1, noiseDetailVar2);
        float red = noise(xoff)*255;
        float green = noise(yoff)*255;


        float R = map(noise(xoff, yoff, zoff), 0, 1, 0, 255); //
        float G = map(noise(xoff+600, yoff+900, zoff), 0, 1, 0, 255); //add some offset to xoff and yoff so that R, G and B are not equal
        float B = map(noise(xoff+200, yoff+50, zoff), 0, 1, 0, 255); // add some offset to xoff and yoff so that R, G and B are not equal


        // Try using this line instead
        //float bright = random(0,255);

        // Set each pixel onscreen to a grayscale value
        pixels[x+y*width] = color(G, 90);
      }
      xoff += 0.2;   // Increment xoff
    }

    updatePixels();

    zoff = zoff - 0.3;
  }
}

