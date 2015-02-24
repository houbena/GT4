int windowWidth = 500;
int windowHeight = 500;
int height = windowHeight;
int width = windowWidth;
int mouseXValue = windowWidth/2;
int mouseYValue = windowHeight/2;

int bodyWidth = 60;
int bodyHeight = 100;
int numOfAng = 8;
int bodyPosX = width/2;
int bodyPosY = height/2;

float[] x = new float[numOfAng+1];
float[] y = new float[numOfAng+1];

float[] angle = new float[numOfAng+1];

float[] init ={
0,
PI/3,
PI/6,
PI/3,
PI/4,
2*PI/3,
-PI/6,
2*PI/3,
-PI/4}; // idle pose angles

float segLength = 65;
float headY= height/2 - 60;
float jointR = 10;
float aU = PI/6; //AngleUnit to keep code simpler

float[] angleA= {
0.0, // influence of figure A
2 * aU - init[1],
aU - init[2],
4 * aU - init[3],
-2 * aU - init[4],
6 * aU - init[5],
3 * aU - init[6],
4 * aU - init[7],
-2 * aU - init[8]};

float angle1B = 0 - init[1];
float angle2B = -3 * aU - init[2];
float angle3B = 2 * aU - init[3];
float angle4B = 2 * aU - init[4];
float angle5B = 4 * aU - init[5];
float angle6B = -aU - init[6];
float angle7B = 2 * aU - init[7];
float angle8B = 2 * aU - init[8];
float infB = 0.0; //Influence of figure B

float angle1C = aU - init[1];
float angle2C = aU - init[2];
float angle3C = -aU/2 - init[3];
float angle4C = 4 * aU - init[4];
float angle5C = 5 * aU - init[5];
float angle6C = -aU - init[6];
float angle7C = 13 * aU/2 - init[7];
float angle8C = -4 * aU - init[8];
float infC = 0.0; //Influence of figure C

float angle1D = -aU/2 - init[1];
float angle2D = -3 * aU - init[2];
float angle3D = 2 * aU - init[3];
float angle4D = 2 * aU - init[4];
float angle5D = 6 * aU - init[5];
float angle6D = 3 * aU - init[6];
float angle7D = 4 * aU - init[7];
float angle8D = -2 * aU - init[8];
float infD = 0.0;

PImage img_bg;
PImage img_up;
PImage img_buttom;
PImage img_right;
PImage img_left;

void setup(){
  size(windowWidth, windowHeight);
  
  img_bg = loadImage("gt4_bg.jpg");
//  img_up = loadImage("up.jpg");
//  img_buttom = loadImage("buttom.jpg");
//  img_left = loadImage("left.jpg");
//  img_right = loadImage("right.jpg");
}

void mousePosInfluence(){
    mouseXValue = mouseX*2 - width/2;
    mouseYValue = mouseY*2 - width/2;
    
    if (mouseXValue < (windowWidth/2)){
      angleA[0] = (width/2 - mouseXValue) / float(windowWidth/2); // in %
    }
    if (mouseXValue > (windowWidth/2)){
      infB = (mouseXValue - width/2) / float(windowWidth/2); 
    }
    if (mouseYValue > (windowHeight/2)){
      infC = (mouseYValue - height/2) / float(windowHeight/2); 
    }
    if (mouseYValue < (windowHeight/2)){
      infD = (height/2 - mouseYValue) / float(windowHeight/2);
    }
}

void mouseMoved(){
  mousePosInfluence();
}

void mouseDragged(){
  if (mouseX > (bodyPosX - bodyWidth/2) && mouseX < (bodyPosX + bodyWidth/2) && mouseY > (bodyPosY - bodyHeight/2) && mouseY < (bodyPosY + bodyHeight/2)){
    bodyPosX = mouseX;
    bodyPosY = mouseY;
    mousePosInfluence();
  }
}

void draw(){

  x[1] = x[3] = bodyPosX + bodyWidth/2;
  y[1] = y[5] = bodyPosY - bodyHeight/2;
  y[3] = y[7] = bodyPosY + bodyHeight/2;
  x[5] = x[7] = bodyPosX - bodyWidth/2;
  
  background(255);
  imageMode(CENTER);
  image(img_bg, width/2, height/2, 300, 300);
//  image(img_up, width/2, height/8, 150, 150);
//  image(img_buttom, width/2, 7*height/8+20, 150, 150);
//  image(img_right, 7*width/8, height/2, 150, 150);
//  image(img_left, width/8-20, height/2, 150, 150);

  strokeWeight(10); //line thikness
  stroke(127); // line color
  fill(210, 126, 49); //filling color
  //draw body
  rectMode(CENTER);
  rect(bodyPosX, bodyPosY, bodyWidth, bodyHeight);
  
  if ((mouseX<(width*3/4)) && (mouseX>(width/4))){
    headY = height/2-(mouseX/30 + 170/3);
  }
  ellipse(bodyPosX, bodyPosY - 70, 35,45); //Head shape
  
  //Update angles
  angle[1] = updateAngle(angleA[0], angle1A, infB, angle1B, infC, angle1C, infD, angle1D) + init[1];
  if (angle[1] > 4*aU) {angle[1] = 4*aU;}
  if (angle[1] < -3*aU) {angle[1] = -3*aU;}
  angle[2] = updateAngle(angleA[0], angle2A, infB, angle2B, infC, angle2C, infD, angle2D) + init[2];
  if (angle[2] > 5*aU) {angle[2] = 5*aU;}
  if (angle[2] < -5*aU) {angle[2] = -5*aU;}
  angle[3] = updateAngle(angleA[0], angle3A, infB, angle3B, infC, angle3C, infD, angle3D) + init[3];
  if (angle[3] > 5*aU) {angle[3] = 5*aU;}
  if (angle[3] < -4*aU) {angle[3] = -4*aU;}
  angle[4] = updateAngle(angleA[0], angle4A, infB, angle4B, infC, angle4C, infD, angle4D) + init[4];
  if (angle[4] > 5*aU) {angle[4] = 5*aU;}
  if (angle[4] < -5*aU) {angle[4] = -5*aU;}
  angle[5] = updateAngle(angleA[0], angle5A, infB, angle5B, infC, angle5C, infD, angle5D) + init[5];
  if (angle[5] > 9*aU) {angle[5] = 9*aU;}
  if (angle[5] < 2*aU) {angle[5] = 2*aU;}
  angle[6] = updateAngle(angleA[0], angle6A, infB, angle6B, infC, angle6C, infD, angle6D) + init[6];
  if (angle[6] > 5*aU) {angle[6] = 5*aU;}
  if (angle[6] < -5*aU) {angle[6] = -5*aU;}
  angle[7] = updateAngle(angleA[0], angle7A, infB, angle7B, infC, angle7C, infD, angle7D) + init[7];
  if (angle[7] > 10*aU) {angle[7] = 10*aU;}
  if (angle[7] < 1*aU) {angle[7] = 1*aU;}
  angle[8] = updateAngle(angleA[0], angle8A, infB, angle8B, infC, angle8C, infD, angle8D) + init[8];
  if (angle[8] > 5*aU) {angle[8] = 5*aU;}
  if (angle[8] < -5*aU) {angle[8] = -5*aU;}
  
  //right arm
  pushMatrix();
  segment(x[1], y[1], angle[1]);
  segment(segLength, 0, angle[2]);
  popMatrix();
  //right leg
  pushMatrix();
  segment(x[3], y[3], angle[3]);
  segment(segLength, 0, angle[4]);
  popMatrix();
  //left arm
  pushMatrix();
  segment(x[5], y[5], angle[5]);
  segment(segLength, 0, angle[6]);
  popMatrix();
  //left leg
  pushMatrix();
  segment(x[7], y[7], angle[7]);
  segment(segLength, 0, angle[8]);
  popMatrix();
  
  //joints
  ellipse(x[1], y[1], jointR,jointR);
  ellipse(jX(x[1], angle[1]), jY(y[1], angle[1]), jointR, jointR);
  ellipse(x[3], y[3], jointR,jointR);
  ellipse(jX(x[3], angle[3]), jY(y[3], angle[3]), jointR, jointR);
  ellipse(x[5], y[5], jointR,jointR);
  ellipse(jX(x[5], angle[5]), jY(y[5], angle[5]), jointR, jointR);
  ellipse(x[7], y[7], jointR,jointR);
  ellipse(jX(x[7], angle[7]), jY(y[7], angle[7]), jointR, jointR);
}

float jX(float x, float angle){
  return x + segLength * cos(angle);
}

float jY(float y, float angle){
return y + segLength * sin(angle);
}

float updateAngle(float angleA[0], float angleA, float infB, float angleB, float infC, float angleC, float infD, float angleD){
  return angleA[0] * angleA + infB * angleB + infC * angleC + infD * angleD;
}

void segment(float x, float y, float a){
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}
