void setup(){
  size(800, 800);
  background(255);
} 

void draw(){ 
  for(int i = 0; i < width; i = i + 10) {
      for(int j = 0; j < height; j = j + 10) {
      fill(random(255));
      ellipse(i, j, 10, 10);
      }
  }
}
