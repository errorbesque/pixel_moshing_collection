// falling masked image with switching colors
// rg 2018

PImage foreground; 
PImage background;
String imgFileName = "graybg"; // bg
String imgFileName2 = "nathalie_IMG_0630_bg"; // foreground
String fileTypes = "gif";
boolean doresize = true;
int counter=1;
int shiftiny =25;
color colors[] = {color(255,100,100), color(100,255,100), color(100,100,255), color(255,255,100), color(100,255,255), color(255,100,255), color(240,128,128), color(255,215,0), color(124,252,0),color(224,255,255), color(30,144,255),color(186,85,211), color(255,20,147)};
int direction = 1;
void setup() {
  // load images
  foreground = loadImage(imgFileName2+"."+fileTypes); 
  background = loadImage(imgFileName+"."+fileTypes); 
  if (doresize)  {foreground.resize(0,800); background.resize(0,800);}

  // use only numbers (not variables) for the size() command in Processing3
  size(1, 1);
  
  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(background.width, background.height);
  
  // load image onto surface - scale to the available width,height for display
  image(background, 0, 0, width, height);
  background.loadPixels();
  foreground.loadPixels();

}

void update() {
  if (counter==0) delay(1000);
counter+=direction;
delay(50); // wait .5 s
}

void draw() {
  update();
  
  // draw background
  // draw foreground
  noTint();
  image(background,0,0);
  if (counter==0) {
    image(foreground,0,0);
    direction=1;
  } else {
  for (int i=0; i<=counter;i++){
    tint(colors[i%colors.length],127);
    image(foreground,-2*i,shiftiny*i);
  }
}
/*
  tint(color(255,255,255));
  image(foreground,-2*counter,shiftiny*counter);
*/
  if(counter == colors.length) {
    direction=-1;
  } 
}
