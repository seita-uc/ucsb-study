// Getting the color from an image
// Using: "Persistence of Memory" by Salvador Dalí

PImage imgDali;
int imgDaliWidth, imgDaliHeight;
PImage imgPortrait;
color[] colors = new color[10];

void setup() {
    size(800, 800);
    imgDali = loadImage("images/persistence_of_memory.jpg");
    imgDaliWidth = imgDali.width;
    imgDaliHeight = imgDali.height;
    imgPortrait = loadImage("images/me.png");
    imgPortrait.filter(THRESHOLD);
    extractColors();
    for(int i = 0; i < height; i++) {
        int y = int(random(i, i+100));
        stroke(colors[int(random(0,colors.length))]);
        strokeWeight(int(random(3, 10)));
        line(0, y, width, y);
    }
}

void draw() {
    /*image(imgPortrait, 0, 0);*/
    /*float x = mouseX;*/
    /*float y = mouseY;*/
    /*float c = imgPortrait.get(int(x), int(y));*/
    /*println(c);*/

    for(int i = 0; i < 10000; i++) {
        int x = int(random(width));
        int y = int(random(height));
        float c = imgPortrait.get(x, y);

        if(c < -1) {
            fill(colors[0]);
            stroke(colors[0]);
            /*strokeWeight(int(random(3, 10)));*/
            /*line(x, y, x-random(5), y-5);*/
            noStroke();
            ellipse(x, y, 3, 3);
        } 
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
