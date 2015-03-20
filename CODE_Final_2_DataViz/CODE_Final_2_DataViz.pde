/* ---------------------------------------------------------------------------
 Bootcamp 2014 CODE Final Project
 Umi Fadilah W. Syam
 http://a.parsons.edu/~syamu557/
 MFADT, Parsons The New School for Design
 
 Data Visualization of "Cheap Eats Near School"
 Visualizing all of the cheap eats options near Parsons DT Building
 based on YELP. Data Scraped with https://www.kimonolabs.com/
 --------------------------------------------------------------------------- */
//import processing.pdf.*;
PImage legendR, logo, legend;
PImage bg;
boolean record;
float myScale;
ArrayList <CheapEats> myCheapEats;

void setup() {
//  size(displayWidth, displayHeight);
//  size(1920,1080);
    size(1600,900);
  bg = loadImage("bg3.png");

  legendR = loadImage("Legend2.png");
  logo = loadImage("Logo.png");
  legend = loadImage("legend.png");

  colorMode(HSB, 360, 100, 100);
//  myScale = 4;
  myScale = 2.5;
  myCheapEats = new ArrayList <CheapEats>();

  String[] wholeData = loadStrings("data/CheapEatsNearSchool.tsv");
  splitData(wholeData);

  smooth();
}

void draw() {
  background(bg);
//  background(360);
  image(logo, -20, 0);
  image(legendR, 0, height - (int)legendR.height); 
  image(legend, width - (int)legend.width, height - (int)legend.height);
//  println((int)legendR.width);
  translate(width/2, height/2);
  //  rotate(frameCount*0.01);

  drawRadius();
  for (CheapEats c : myCheapEats) {
    c.display();
  }

}

void mousePressed() {
  for (CheapEats c : myCheapEats) {
    if (c.isHovering()) {
      link(c.placesUrl, "_new");
    }
  }
  record = true;
}

void splitData(String[] myArray) {
  for (int i = 0; i < myArray.length; i++) {
    String myRow = myArray[i];         

    String[] columns = split(myRow, "\t");
    String placesName = trim(columns[0]);
    String placesUrl = trim(columns[1]);
    String price = trim(columns[2]);
    int nReviews = parseInt(trim(columns[3]));
    String cuisineCategory = trim(columns[4]);
    String cuisineUrl = trim(columns[5]);
    float radius = parseFloat(trim(columns[6]));

    CheapEats tempGraph = new CheapEats(placesName, placesUrl, price, nReviews, cuisineCategory, cuisineUrl, radius);
    myCheapEats.add(tempGraph);
  }  
  //debug();
}

void debug() {  
  for (int i = 0; i < myCheapEats.size (); i++) {
    CheapEats temp = myCheapEats.get(i);
    println(temp.placesName + "\t" + temp.cuisineCategory + "\t" + temp.radius);
  }
}

void drawRadius() {

  for (int i = 0; i < myCheapEats.size (); i++) {
    noFill();

    strokeWeight(3);
    stroke(240);
    
    ellipse(0, 0, myCheapEats.get(i).radius*2000, myCheapEats.get(i).radius*2000);
//    ellipse(0, 0, myCheapEats.get(i).radius*2400, myCheapEats.get(i).radius*2400);
//    ellipse(0, 0, myCheapEats.get(i).radius*3200, myCheapEats.get(i).radius*3200);
    //println(myCheapEats.get(i).radius);
  }

}

boolean sketchFullScreen() {
  return false;
}

