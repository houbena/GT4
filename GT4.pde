int windowWidth = 400;
int windowHeight = 400;

float x, y;
float angle1 = 0.0;
float angle2 = 0.0;
float segLength = 65;
int height = windowHeight;
float headY= height/2 - 60;
  
void setup(){
  size(windowWidth, windowHeight);

  x = width/2 + 25;
  y = height/2 - 50;
}

void draw(){
  background(200);

  strokeWeight(5);
  rect(width/2-25, height/2-50, 50,100);
  
  if ((mouseX<(width*3/4)) && (mouseX>(width/4))){
    headY = height/2-(mouseX/30 + 170/3);
  }
  ellipse(width/2, headY, 40,45);
  
  strokeWeight(10);
  angle1 = (mouseX/float(width))*2*PI;
  angle2 = (mouseY/float(height))*PI;
  
  pushMatrix();
  segment(x, y, angle1);
  segment(segLength, 0, angle2);
  popMatrix();
  
}

void segment(float x, float y, float a){
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}
