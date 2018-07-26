/*
 simple pixel sorter
 rg
 march 2017
 very simple algo -- with some probability, if pixel to diagonal left is darker, switch places. iterate.
 */


// image path is relative to sketch directory
PImage img;
PImage toplayer; // gets added on top to every frame
String imgFileName = "IMG_1262_edit";
String fileType = "jpg";
int numpixels = 1000; // before breaking out of loop
int globaliterations = 0;
int ymod = -1; // (xmod,ymod): (-1,-1) compares to top left diagonal... (-1,0) compares to left... (0,-1) compares to vertical, etc...
int xmod = 1;
boolean persistenttrails=false; // do pixels switch or do they drag

int largediff = 50000; // may need to tweak these depending on image
int smalldiff = 500; // 500; 

void setup() {
  println("entering setup");
  img = loadImage(imgFileName+"."+fileType); // load
  //img.resize(0,1000);

  // toplayer.mask(mask1);
  
  // use only numbers (not variables) for the size() command in Processing3
  size(1, 1);
  
  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  
  // load image onto surface - scale to the available width,height for display
  image(img, 0, 0, width, height);
  img.loadPixels();
  // mask1, toplayer don't change
}

void update() {
  // ver1 has these deleted
  //ymod = round(random(1));
  //globaliterations++;
  img.loadPixels();
  int val1 = 0; // value of pixel of interest
  int val2 = 0; // value of pixel to compare it to
  int counter = 0; // number of changes
  float percentchance = 0.4; // percent chance that pixels will switch, for more uniformity / randomness

  
  search: // labeled search so i can break out of both loops
  for (int i=int(random(1,img.width))+1; i<(img.width-1); i++) { // note start at random pixel
  for (int j=int(random(1,img.height))+1; j<(img.height-1); j+=2) {
     if ( counter>numpixels) { // cap established because if you let this go to completion, it's quite slow
         // println("search broken"); 
         break search;
    }
    val1 = img.pixels[i+j*img.width];
    val2 = img.pixels[i+xmod+(j+ymod)*(img.width)];
     percentchance = 0.7; 
   
    if ((val1-val2) > largediff) { // test for differences... if large, then
      // println(mask1.pixels[i+j*img.width]);

      if ( random(1)<percentchance) { // and if random test passes
        counter++; // swap pixels
        if (persistenttrails) {
        img.pixels[i+xmod+(j+ymod)*(img.width)]=val1; 
        // img.pixels[i+j*img.width]=val2;
      
          } else {
        img.pixels[i+xmod+(j+ymod)*(img.width)]=val1; 
        img.pixels[i+j*img.width]=val2;

      
      }
    }
      else if ((val1-val2) > smalldiff) {  // if small difference, 
        if ( random(1)<(percentchance/2)) { // lower (half the) likelihood, but still a chance of swapping. intended effect = big delta in value is more likely to swap than small delta
        counter++;
        img.pixels[i+j*img.width]=val2;
        img.pixels[i+xmod+(j+ymod)*(img.width)]=val1;}
            
      } 
    } // else if
  } // for j
  } // for i 
  img.updatePixels();
}

void draw() {
  update();
  image(img,0,0);
  // image(toplayer,0,0);
  // debugging -- > get color under mouse
  // color color_under_mouse = mask1.get(mouseX,mouseY);
  // println(color_under_mouse);
}