// ART 22 - Intro to Data Visualization

Table table;
int rows;
float maxSize = 250;
float [] animatedSize;

void setup() {
  size(1024, 768, FX2D);
  background(0);
  
  loadDataSet();
  
}

void draw() {
  background(0);

  showData();
}
