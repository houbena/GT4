/////////////////////////////////////////////////////
/// By Houssein Ben Amor, WS14/15, HTW Berlin, GT4///
/////////////////////////////////////////////////////

int windowWidth = 500;
int windowHeight = 500;
int height = windowHeight;
int width = windowWidth;
int mouseXValue = windowWidth/2;
int mouseYValue = windowHeight/2;

/////////////// start of BLOCK /// modifiable variables ///////////////
int segThik = 10; // line thinkness, for head, body and segments
color segCol = #7F7F7F; // line color, initial #7F7F7F

color fillCol = #D27E31; // filling color, initial #D27E31
int bodyWidth = 60;
int bodyHeight = 100;

float segLength = 65; // segment length
float jointR = 10; // joints size
/////////////// end of BLOCK /// modifiable variables ///////////////

// initial position of body
int bodyPosX = width/2; 
int bodyPosY = height/2;

final int numOfAng = 8; // if changed, several parts of code should be maintained
float[] x = new float[numOfAng+1];
float[] y = new float[numOfAng+1];
float[] angle = new float[numOfAng+1];
float aU = PI/6; // AngleUnit to keep code simpler: twelfth of a circle

float[] init ={  // initial pose angles
  0,
  PI/3,
  PI/6,
  PI/3,
  PI/4,
  2*PI/3,
  -PI/6,
  2*PI/3,
  -PI/4
};

float[] angleMax = {
  0.0, // place 0, not used
  4*aU,
  5*aU,
  5*aU,
  5*aU,
  9*aU,
  5*aU,
  10*aU,
  5*aU
};

float[] angleMin = {
  0.0, // place 0, not used
  -3*aU,
  -5*aU,
  -4*aU,
  -5*aU,
  2*aU,
  -5*aU,
  1*aU,
  -5*aU
};

float[] angleA= {
  0.0, // influence of figure A
  2 * aU - init[1],
  aU - init[2],
  4 * aU - init[3],
  -2 * aU - init[4],
  6 * aU - init[5],
  3 * aU - init[6],
  4 * aU - init[7],
  -2 * aU - init[8]
};

float[] angleB= {
  0.0, // influence of figure B
  0 - init[1],
  -3 * aU - init[2],
  2 * aU - init[3],
  2 * aU - init[4],
  4 * aU - init[5],
  -aU - init[6],
  2 * aU - init[7],
  2 * aU - init[8]
};

float[] angleC= {
  0.0, // influence of figure C
  aU - init[1],
  aU - init[2],
  -aU/2 - init[3],
  4 * aU - init[4],
  5 * aU - init[5],
  -aU - init[6],
  13 * aU/2 - init[7],
  -4 * aU - init[8]
};

float[] angleD= {
  0.0, // influence of figure D
  -aU/2 - init[1],
  -3 * aU - init[2],
  2 * aU - init[3],
  2 * aU - init[4],
  6 * aU - init[5],
  3 * aU - init[6],
  4 * aU - init[7],
  -2 * aU - init[8]
};

PImage img_bg;

void setup(){
  size(windowWidth, windowHeight);
  img_bg = loadImage("gt4_bg.jpg");
  
  updateMove();
}

void mouseMoved(){
  mousePosInfluence();
  updateMove();
}

void mouseDragged(){
  // move body when mouse is dragged and its position is in or oáround body
  if (mouseX > (bodyPosX - bodyWidth) && mouseX < (bodyPosX + bodyWidth)
  && mouseY > (bodyPosY - bodyHeight) && mouseY < (bodyPosY + bodyHeight)){
    bodyPosX = mouseX;
    bodyPosY = mouseY;
    mousePosInfluence();
  }
  updateMove();
}

void draw(){
  background(255);
  imageMode(CENTER);
  image(img_bg, width/2, height/2, 300, 300);

  strokeWeight(segThik); //line thikness
  stroke(segCol); // line color
  fill(fillCol); //filling color
  
  //draw body
  rectMode(CENTER);
  rect(bodyPosX, bodyPosY, bodyWidth, bodyHeight);
  ellipse(bodyPosX, bodyPosY - 70, 35,45); //Head shape
  
  drawLegOrArm(x[1], y[1], angle[1], angle[2]);  //right arm
  drawLegOrArm(x[3], y[3], angle[3], angle[4]);  //right leg
  drawLegOrArm(x[5], y[5], angle[5], angle[6]);  //left arm
  drawLegOrArm(x[7], y[7], angle[7], angle[8]);  //left leg
}

void mousePosInfluence(){
    mouseXValue = mouseX*2 - width/2;
    mouseYValue = mouseY*2 - width/2;
    
    if (mouseXValue < (windowWidth/2)){
      angleA[0] = (width/2 - mouseXValue) / float(windowWidth/2); // in %
    }
    if (mouseXValue > (windowWidth/2)){
      angleB[0] = (mouseXValue - width/2) / float(windowWidth/2); 
    }
    if (mouseYValue > (windowHeight/2)){
      angleC[0] = (mouseYValue - height/2) / float(windowHeight/2); 
    }
    if (mouseYValue < (windowHeight/2)){
      angleD[0] = (height/2 - mouseYValue) / float(windowHeight/2);
    }
}

float updateAngle(float infA, float angleA, float infB, float angleB, float infC, float angleC, float infD, float angleD){
  return infA * angleA + infB * angleB + infC * angleC + infD * angleD;
}

void drawLegOrArm(float p1_x, float p1_y, float ang1, float ang2){
  pushMatrix();
    segment(p1_x, p1_y, ang1);
    ellipse(0, 0, jointR,jointR);
    segment(segLength, 0, ang2);
    ellipse(0, 0, jointR, jointR);
  popMatrix();
}

void segment(float x, float y, float a){
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}

void updateMove(){
  // update angles
  for (int i = 1; i <= numOfAng; i++){
    angle[i] = updateAngle(angleA[0], angleA[i], angleB[0], angleB[i], angleC[0], angleC[i], angleD[0], angleD[i]) + init[i];
    if (angle[i] > angleMax[i]) {angle[i] = angleMax[i];}
    if (angle[i] < angleMin[i]) {angle[i] = angleMin[i];}
  }
  
  // update joints (Knoten)
  x[1] = x[3] = bodyPosX + bodyWidth/2;
  y[1] = y[5] = bodyPosY - bodyHeight/2;
  y[3] = y[7] = bodyPosY + bodyHeight/2;
  x[5] = x[7] = bodyPosX - bodyWidth/2;
}
