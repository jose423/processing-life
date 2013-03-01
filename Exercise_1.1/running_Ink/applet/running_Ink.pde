Inkblot friend;
int clicked = 0;

void setup() {
  size(600, 600);
  background(255);
  smooth();
  friend = new Inkblot();
}

void draw(){
   friend.draw(); 
}

void mouseDragged() {
  strokeWeight(4);
  line(friend.blot.x,friend.blot.y,friend.blot.x,friend.blot.y);
  line((600-friend.blot.x),friend.blot.y,(600-friend.blot.x),friend.blot.y);
}

void mouseClicked() {

//the line below allows every image to be saved once clicked
//saveFrame("rosarch-####.tif"); 
  background(255-clicked,255-(clicked)*(clicked),clicked,.9);
  
  clicked++;
  
  if(clicked > 1){ 
    background(255-(clicked)*(clicked),255-random(255),255-random(255),9);
  }
   if(clicked%5 == 0){
    PImage b;
    b = loadImage("copy-left-right-center.png");
    image(b, 0, 0);
    filter(BLUR);
    friend.colorize = true;
  }else if(clicked%6 == 0){
    PImage b;
    String url = "Frost.png";
    b = loadImage(url, "png");
    image(b, 0, 0,600,600);
    filter(INVERT);
    friend.colorize = true;
  }else if(clicked%7 == 0){
    PImage b;
    String url = "rosarch-0580.tif";
    b = loadImage(url);
    image(b, 0, 0,600,600);
    filter(INVERT);
    friend.colorize = true;
  }
  else{
   friend.colorize = false;
  }
 }
 
