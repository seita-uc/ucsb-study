// Color Exercise
import processing.pdf.*;

PImage albers;
color myColor;
int x, y;
float circleSize = 10;

void setup() {
 size(500, 500);
 albers = loadImage("images/me.png");
}

boolean record = true;
void draw() {
    if (record) {
        beginRecord(PDF, String.format("images/screenshot_%s%s%s%s%s.pdf", month(), day(), hour(), minute(), second()));
        record = false;
    } 
  //fill(255, 1);
  //rect(0, 0, width, height);
  
  x = floor(random(width));
  y = floor(random(height));
  
  //x = mouseX;
  //y = mouseY;
  
  circleSize = random(30);
  myColor = albers.get(x, y);
  fill(myColor);
  noStroke();
  ellipse(x, y , circleSize, circleSize);
}

void keyPressed() {
    endRecord();
    record = true;
}

