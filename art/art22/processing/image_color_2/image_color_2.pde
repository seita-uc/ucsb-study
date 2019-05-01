// Getting the color from an image
// Using: "Woman Leaving the Psychoanalyst" by Remedios Varo

PImage colorPic;
int colorW, colorH;

void setup() {
    size(500, 500);
    colorPic = loadImage("images/remediosVaro.jpg");
    colorW = colorPic.width;
    colorH = colorPic.height;
    println("w: ", colorW, " / h: ", colorH);
}

void draw() {
    color temporaryColor = colorPic.get(int(random(colorW)), int(random(colorH)));
    fill(temporaryColor);
    noStroke();
    rect(random(width), 0, random(5, 10), height);
}

