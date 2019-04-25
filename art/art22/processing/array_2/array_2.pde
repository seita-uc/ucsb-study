float x = 100;
float y = 100;
float limit = 20;
float pX = 0;
float pSpeed = 1;

void setup() {
  size(800, 800);
}

void draw() {
  background(255);
  stroke(0);
  line(x, y, x+limit, y);
  
  pX += pSpeed;
  
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(x+pX, y, 5, 5);
  
  if(pX > limit) {
    pX = 0;
  }
}
