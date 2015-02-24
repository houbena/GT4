int windowWidth = 1000;
int windowHeight = 500;
int height = windowHeight;
int width = windowWidth;

int bodyWidth = 5;
int bodyHeight = 100;
int bodyPosX = width/2;
int bodyPosY = height/3;
float segLength = 65;

float x1, y1;
float x3, y3;
float x5, y5;
float x7, y7;

int mouseXValue = windowWidth/2;
int mouseYValue = windowHeight/2;

float angle1 = 0.0;
float angle2 = 0.0;
float angle3 = 0.0;
float angle4 = 0.0;
float angle5 = 0.0;
float angle6 = 0.0;
float angle7 = 0.0;
float angle8 = 0.0;

float init1 = 2*PI/6;
float init2 = -PI/6;
float init3 = 3*PI/8;
float init4 = PI/4;
float init5 = 2*PI/3;
float init6 = -PI/6;
float init7 = 3*PI/8;
float init8 = PI/4;


float headY= height/2 - 60;
float jointR = 10;
float aU = PI/6; //AngleUnit to keep code simpler

float angle1A = 2 * aU - init1;
float angle2A = -aU - init2;
float angle3A = 3.5 * aU - init3;
float angle4A = aU - init4;
float angle5A = 4 * aU - init5;
float angle6A = -aU - init6;
float angle7A = 1.5*aU - init7;
float angle8A = aU - init8;
float infA = 0.0; //Influence of figure A

float angle1B = 4 * aU - init1;
float angle2B = -aU - init2;
float angle3B = 1.5*aU - init3;
float angle4B = aU - init4;
float angle5B = 2 * aU - init5;
float angle6B = -aU - init6;
float angle7B = 3.5 * aU - init7;
float angle8B = aU - init8;
float infB = 0.0; //Influence of figure B

float angle1C = aU - init1;
float angle2C = aU - init2;
float angle3C = -aU/2 - init3;
float angle4C = 4 * aU - init4;
float angle5C = 5 * aU - init5;
float angle6C = -aU - init6;
float angle7C = 13 * aU/2 - init7;
float angle8C = -4 * aU - init8;
float infC = 0.0; //Influence of figure C

float angle1D = -aU/2 - init1;
float angle2D = -3 * aU - init2;
float angle3D = 2 * aU - init3;
float angle4D = 2 * aU - init4;
float angle5D = 6 * aU - init5;
float angle6D = 3 * aU - init6;
float angle7D = 4 * aU - init7;
float angle8D = -2 * aU - init8;
float infD = 0.0;

PImage img_bg;
PImage img_up;
PImage img_buttom;
PImage img_right;
PImage img_left;
PImage img_street;

float mouseXpc;

void setup(){
  size(windowWidth, windowHeight);
  
  img_street = loadImage("street.png");
//  img_bg = loadImage("gt4_bg.jpg");
//  img_up = loadImage("up.jpg");
//  img_buttom = loadImage("buttom.jpg");
//  img_left = loadImage("left.jpg");
//  img_right = loadImage("right.jpg");
}

void mousePosInfluence(){
    mouseXValue = mouseX*2 - width/2;
    mouseYValue = mouseY*2 - width/2;
    
    mouseXpc = 6*float(mouseX)/1000;
    infA = (sin(2*PI*mouseXpc)/2)+0.5;
    infB = (cos(2*PI*mouseXpc)/2)+0.5;
        println(infA + " A:B " + infB);

    if (mouseXValue < (windowWidth/2)){
//      infA = (width/2 - mouseXValue) / float(windowWidth/2); // in %
    }
    if (mouseXValue > (windowWidth/2)){
//      infB = (mouseXValue - width/2) / float(windowWidth/2); 
    }
    if (mouseYValue > (windowHeight/2)){
 //     infC = (mouseYValue - height/2) / float(windowHeight/2); 
    }
    if (mouseYValue < (windowHeight/2)){
   //   infD = (height/2 - mouseYValue) / float(windowHeight/2);
    }
}

void mouseMoved(){
  mousePosInfluence();
}

void mouseDragged(){
 // if (mouseX > (bodyPosX - bodyWidth/2 -50) && mouseX < (bodyPosX + bodyWidth/2+50) && mouseY > (bodyPosY - bodyHeight/2) && mouseY < (bodyPosY + bodyHeight/2)){
    bodyPosX = mouseX;
    bodyPosY = int(5*sin(2*2*PI*mouseXpc)+height/3);
    mousePosInfluence();
  //}
}

void draw(){
  x1 = bodyPosX + bodyWidth/2;
  y1 = bodyPosY - bodyHeight/2;
  x3 = bodyPosX + bodyWidth/2;
  y3 = bodyPosY + bodyHeight/2;
  x5 = bodyPosX - bodyWidth/2;
  y5 = bodyPosY - bodyHeight/2;
  x7 = bodyPosX - bodyWidth/2;
  y7 = bodyPosY + bodyHeight/2;
  
  background(255);
  imageMode(CORNER);
  image(img_street, 0, height-300, width, height);
   
 // image(img_bg, width/2, height/2, 300, 300);
//  image(img_up, width/2, height/8, 150, 150);
//  image(img_buttom, width/2, 7*height/8+20, 150, 150);
//  image(img_right, 7*width/8, height/2, 150, 150);
//  image(img_left, width/8-20, height/2, 150, 150);

  strokeWeight(10); //line thikness
    fill(210, 126, 49); //filling color

  pushMatrix();
    stroke(117); // line color
    segment(x1, y1, angle1);    //right arm
    ellipse(0, 0, jointR,jointR);
      stroke(107); // line color
    segment(segLength, 0, angle2);
    ellipse(0, 0, jointR, jointR);
  popMatrix();
  
    //right leg
  pushMatrix();
      stroke(117); // line color
  segment(x3, y3, angle3);
      ellipse(0, 0, jointR,jointR);
   stroke(107); // line color
  segment(segLength, 0, angle4);
    ellipse(0, 0, jointR, jointR);
  popMatrix();

  stroke(127); // line color
  //draw body
  rectMode(CENTER);
  rect(bodyPosX, bodyPosY, bodyWidth, bodyHeight);
   
    if ((mouseX<(width*3/4)) && (mouseX>(width/4))){
    headY = height/2-(mouseX/30 + 170/3);
  }
  ellipse(bodyPosX, bodyPosY-bodyHeight/2-30, 35,45); //Head shape
   
  pushMatrix();
      stroke(137); // line color
  segment(x5, y5, angle5);    //left arm
  ellipse(0, 0, jointR,jointR);
      stroke(147); // line color
  segment(segLength, 0, angle6);
  ellipse(0, 0, jointR, jointR);
  popMatrix();
  
  //left leg
  pushMatrix();
        stroke(137); // line color
  segment(x7, y7, angle7);
    ellipse(0, 0, jointR,jointR);
      stroke(147); // line color
  segment(segLength, 0, angle8);
    ellipse(0, 0, jointR, jointR);
  popMatrix();

  
  //Update angles
  angle1 = updateAngle(infA, angle1A, infB, angle1B, infC, angle1C, infD, angle1D) + init1;
  //if (angle1 > 4*aU) {angle1 = 4*aU;}
  //if (angle1 < -3*aU) {angle1 = -3*aU;}
  angle2 = updateAngle(infA, angle2A, infB, angle2B, infC, angle2C, infD, angle2D) + init2;
  //if (angle2 > 5*aU) {angle2 = 5*aU;}
  //if (angle2 < -5*aU) {angle2 = -5*aU;}
  angle3 = updateAngle(infA, angle3A, infB, angle3B, infC, angle3C, infD, angle3D) + init3;
  //if (angle3 > 5*aU) {angle3 = 5*aU;}
  //if (angle3 < -4*aU) {angle3 = -4*aU;}
  angle4 = updateAngle(infA, angle4A, infB, angle4B, infC, angle4C, infD, angle4D) + init4;
  //if (angle4 > 5*aU) {angle4 = 5*aU;}
  //if (angle4 < -5*aU) {angle4 = -5*aU;}
  angle5 = updateAngle(infA, angle5A, infB, angle5B, infC, angle5C, infD, angle5D) + init5;
  //if (angle5 > 9*aU) {angle5 = 9*aU;}
  //if (angle5 < 2*aU) {angle5 = 2*aU;}
  angle6 = updateAngle(infA, angle6A, infB, angle6B, infC, angle6C, infD, angle6D) + init6;
  //if (angle6 > 5*aU) {angle6 = 5*aU;}
  //if (angle6 < -5*aU) {angle6 = -5*aU;}
  angle7 = updateAngle(infA, angle7A, infB, angle7B, infC, angle7C, infD, angle7D) + init7;
  //if (angle7 > 10*aU) {angle7 = 10*aU;}
  //if (angle7 < 1*aU) {angle7 = 1*aU;}
  angle8 = updateAngle(infA, angle8A, infB, angle8B, infC, angle8C, infD, angle8D) + init8;
  //if (angle8 > 5*aU) {angle8 = 5*aU;}
  //if (angle8 < -5*aU) {angle8 = -5*aU;} 
}

float jX(float x, float angle){
  return x + segLength * cos(angle);
}

float jY(float y, float angle){
return y + segLength * sin(angle);
}

float updateAngle(float infA, float angleA, float infB, float angleB, float infC, float angleC, float infD, float angleD){
  return infA * angleA + infB * angleB;
}

void segment(float x, float y, float a){
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}
