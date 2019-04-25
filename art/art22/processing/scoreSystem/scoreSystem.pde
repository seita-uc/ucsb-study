int totals = 100;
float limitMin = 15;
float limitMax = 150;
float speedMin = 0.5;
float speedMax = 5;

float[] x = new float[totals];
float[] y = new float[totals];
float[] speed = new float[totals];
float[] particleX = new float[totals];
float[] limit = new float[totals];
Boolean showBackground = true;

void setup() {
  size(800, 800);
  fillArrays();
}

void draw() {
  if(random(100) > 80) {
    showBackground = !showBackground;
  }
  if(showBackground) {
    background(0);
  } 
  showSystem();
}

void keyPressed() {
  showBackground = !showBackground;
}
