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

int walk_speed = 6;

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

PImage img_street;

float mouseXpc;

void setup(){
  size(windowWidth, windowHeight);
  
  img_street = loadImage("street.png");
}

void mousePosInfluence(){
    mouseXValue = mouseX*2 - width/2;
    mouseYValue = mouseY*2 - width/2;
    
    mouseXpc = walk_speed*float(mouseX)/1000;
    infA = (sin(2*PI*mouseXpc)/2)+0.5;
    infB = (cos(2*PI*mouseXpc)/2)+0.5;
    println(int(infA*100) + " A:B " + int(infB*100));
}

void mouseMoved(){
  mousePosInfluence();
}

void mouseDragged(){
 // if (mouseX > (bodyPosX - bodyWidth/2 -50) && mouseX < (bodyPosX + bodyWidth/2+50) && mouseY > (bodyPosY - bodyHeight/2) && mouseY < (bodyPosY + bodyHeight/2)){
    bodyPosX = mouseX;
    bodyPosY = int(6*cos(2*2*PI*mouseXpc)+height/3);
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
  angle1 = updateAngle(infA, angle1A, infB, angle1B) + init1;
  angle2 = updateAngle(infA, angle2A, infB, angle2B) + init2;
  angle3 = updateAngle(infA, angle3A, infB, angle3B) + init3;
  angle4 = updateAngle(infA, angle4A, infB, angle4B) + init4;
  angle5 = updateAngle(infA, angle5A, infB, angle5B) + init5;
  angle6 = updateAngle(infA, angle6A, infB, angle6B) + init6;
  angle7 = updateAngle(infA, angle7A, infB, angle7B) + init7;
  angle8 = updateAngle(infA, angle8A, infB, angle8B) + init8;
}

float updateAngle(float infA, float angleA, float infB, float angleB){
  return infA * angleA + infB * angleB;
}

void segment(float x, float y, float a){
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}
