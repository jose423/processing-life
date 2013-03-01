Party p1, p2;

void setup(){
  size(500, 500);
  p1 = new Party("Perlin", 0.1, 0.2);
  p2 = new Party("Random", 0,0);
}

void draw(){
   background(255);
   p1.draw();
   p2.draw();
}
