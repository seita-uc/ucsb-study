int cols = 30;
int rows = 30;
float maxSize = 50;
float[][] x = new float[cols][rows];
float[][] y = new float[cols][rows];
int[][] symbol = new int[cols][rows];
float[][] symbolSize = new float[cols][rows];

void setup(){
  size(500, 500);
  populateGrid();
}

void draw(){
  background(0);
  showGrid();
}

void populateGrid() {
    for(int i = 0; i < cols; i++) {
        float xT = map(i, 0, rows, 0, width);
        for(int j = 0; j < cols; j++) {
            float yT = map(j, 0, rows, 0, height);
            x[i][j] = xT;
            y[i][j] = yT;
            symbol[i][j] = floor(random(3));
            symbolSize[i][j] = random(maxSize);
        }
    }
}

void showGrid() {
    for(int i = 0; i < cols; i++) {
        for(int j = 0; j < rows; j++) {
            strokeWeight(random(1, 2));
            fill(255);
            ellipse(x[i][j], y[i][j], 2, 2);
            if(symbol[i][j] == 0) {
                noFill();
                stroke(255);
                ellipse(x[i][j], y[i][j], symbolSize[i][j], symbolSize[i][j]);
            } else if(symbol[i][j] == 1) {
                strokeWeight(random(0.5, 1));
                if(i < 29 && j < 29) {
                    line(x[i][j], y[i][j], x[i+1][j+1], y[i+1][j+1]);
                }
            }
        }
    }
}

