// Getting the color from an image
// Using: "Persistence of Memory" by Salvador Dalí

PImage imgDali;
int imgDaliWidth, imgDaliHeight;
PImage imgPortrait;
color[] colors = new color[2];

void setup() {
    size(800, 800);
    imgDali = loadImage("images/persistence_of_memory.jpg");
    imgDaliWidth = imgDali.width;
    imgDaliHeight = imgDali.height;
    imgPortrait = loadImage("images/me.png");
    imgPortrait.filter(THRESHOLD);
    extractColors();
}

void draw() {
    /*image(imgPortrait, 0, 0);*/
    /*float x = mouseX;*/
    /*float y = mouseY;*/
    /*float c = imgPortrait.get(int(x), int(y));*/
    /*println(c);*/

    for(int i = 0; i < 100; i++) {
        int x = int(random(width));
        int y = int(random(height));
        float c = imgPortrait.get(x, y);

        if(c < -1) {
            fill(colors[0]);
        /*} else if (c < -60000) {*/
            /*fill(colors[3]);*/
        /*} else if (-100 < c && c < -1) {*/
            /*fill(colors[4]);*/
        } else {
            fill(colors[1]);
        }

        noStroke();
        ellipse(x, y, 5, 5);
    }
}

void extractColors() {
    for(int i = 0; i < colors.length; i++) {
        int x = int(random(imgDaliWidth));
        int y = int(random(imgDaliHeight));
        color tempColor = imgDali.get(x, y);
        colors[i] = tempColor;
    }
}

void keyPressed(){
    if(key == '1') saveFrame("images/portrait_######.jpg");
} 
