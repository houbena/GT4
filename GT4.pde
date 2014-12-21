int windowWidth = 400;
int windowHeight = 400;

float x, y;

int mouseXValue = windowWidth/2;
int mouseYValue = windowHeight/2;

float angle1 = 0.0;
float angle2 = 0.0;
float segLength = 65;
int height = windowHeight;
float headY= height/2 - 60;

float aU = PI/6; //AngleUnit to keep code simpler

float angle1A = 2 * aU;
float angle2A = aU;
float infA = 0.0; //Influence of figure A

float angle1B = 0;
float angle2B = -3 * aU;
float infB = 0.0; //Influence of figure B

float angle1C = aU;
float angle2C = aU;
float infC = 0.0; //Influence of figure C

float angle1D = 0;
float angle2D = -3 * aU;
float infD = 0.0;

PImage img_up;
PImage img_buttom;
PImage img_right;
PImage img_left;

void setup(){
  size(windowWidth, windowHeight);

  x = width/2 + 25;
  y = height/2 - 50;
  
  img_up = loadImage("up.jpg");
  img_buttom = loadImage("buttom.jpg");
  img_left = loadImage("left.jpg");
  img_right = loadImage("right.jpg");
}

void mouseMoved(){
  mouseXValue = mouseX;
  mouseYValue = mouseY;
  
  if (mouseXValue < (windowWidth/2)){
    infA = (windowWidth/2 - mouseXValue) / float(windowWidth/2); // in %
  }
  if (mouseXValue > (windowWidth/2)){
    infB = (mouseXValue - windowWidth/2) / float(windowWidth/2); 
  }
  if (mouseYValue > (windowHeight/2)){
    infC = (mouseYValue - windowHeight/2) / float(windowHeight/2); 
  }
  if (mouseYValue < (windowHeight/2)){
    infD = (windowHeight/2 - mouseYValue) / float(windowHeight/2);
  }
}

void draw(){
  background(191);
  imageMode(CENTER);
  image(img_up, width/2, height/8, 150, 150);
  image(img_buttom, width/2, 7*height/8+20, 150, 150);
  image(img_right, 7*width/8, height/2, 150, 150);
  image(img_left, width/8-20, height/2, 150, 150);
  strokeWeight(5);
  rect(width/2-25, height/2-50, 50,100);
  
  if ((mouseX<(width*3/4)) && (mouseX>(width/4))){
    headY = height/2-(mouseX/30 + 170/3);
  }
  ellipse(width/2, headY, 40,45); //Head shape

  strokeWeight(10); //arm thikness
  
  //Update angles
  angle1 = updateAngle(infA, angle1A, infB, angle1B, infC, angle1C, infD, angle1D);
  angle2 = updateAngle(infA, angle2A, infB, angle2B, infC, angle2C, infD, angle2D);
  ellipse(width/2, headY, 40,45);
  
  pushMatrix();
  segment(x, y, angle1);
  segment(segLength, 0, angle2);
  popMatrix();
}

float updateAngle(float infA, float angleA, float infB, float angleB, float infC, float angleC, float infD, float angleD){
  return infA * angleA + infB * angleB + infC * angleC + infD * angleD;
}

void segment(float x, float y, float a){
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}
