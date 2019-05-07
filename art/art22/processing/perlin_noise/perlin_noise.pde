import processing.pdf.*; 

float x = 250;
float y = 250;
float noiseX = 0.005;
float noiseY = 0.006;
float variationX = 0;
float variationY = 0;

void setup() {
    size(500, 500);
    beginRecord(PDF, "captures/perlin.pdf");
}

void draw() {
    variationX += noiseX;
    variationY += noiseY;
    x = noise(variationX) * width;
    y = noise(variationY) * height;

    fill(random(255));
    strokeWeight(random(5));
    ellipse(x, y, 5, 5);
}

void mousePressed() {
    endRecord();
    exit();
}

