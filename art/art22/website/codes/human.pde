import processing.pdf.*; 

Particle[] particles = new Particle[100];
PImage img;
void setup() {
    size(500, 500);
    beginRecord(PDF, String.format("images/screenshot_%s%s%s%s%s.pdf", month(), day(), hour(), minute(), second()));
    img = loadImage("images/human.jpg");
    /*img.filter(GRAY);*/
    img.filter(THRESHOLD, 0.99);
    img.resize(500, 500);
    for(int i = 0; i < particles.length; i++) { 
        float noiseX = random(0.001, 0.01);
        float noiseY = random(0.001, 0.01);
        particles[i] = new Particle(noiseX, noiseY);
    }
}

void draw() {
    /*image(img, 0, 0);*/
    for(int i = 0; i < particles.length; i++) { 
        particles[i].run();
    }
}

void mousePressed() {
    endRecord();
    exit();
}

Boolean validateLocation(float x, float y) {
        color tempColor = img.get(int(x), int(y));
        if(tempColor < -1) {
            return true;
        }
        return false;
}

class Particle {
    public float px;
    public float py;
    public float pnoiseX;
    public float pnoiseY;
    public float pvariationX;
    public float pvariationY;
    public float psize;
    public float randNum;
    public float R;
    public float G;
    public float B;
    public float randomLocationX;
    public float randomLocationY;

    public Particle(float noiseX, float noiseY) {
        pnoiseX = noiseX;
        pnoiseY = noiseY;
        pvariationX = random(1, 100);
        pvariationY = random(1, 100);
        psize = random(1, 5);
        /*pvariationX = 50;*/
        /*pvariationY = 50;*/
        randNum = random(60);
        R = random(120, 255);
        G = randNum; 
        B = randNum;
        randomLocationX = random(-200, 200);
        randomLocationY = random(-200, 200);
    }

    public void run() {
        pvariationX += pnoiseX;
        pvariationY += pnoiseY;

        px = noise(pvariationX) * width; 
        py = noise(pvariationY) * height;
        if(validateLocation(px, py)) {
            fill(R, G, B, 50);
            strokeWeight(0.1);
            ellipse(px, py, psize, psize);
        } 
        float qx = px + randomLocationX;
        float qy = py + randomLocationY;
        if(validateLocation(qx, qy)) {
            fill(R+randNum, G, B, 50);
            strokeWeight(0.1);
            ellipse(qx, qy, psize, psize);
        } 
        float sx = px - randomLocationX;
        float sy = py - randomLocationY;
        if(validateLocation(sx, sy)) {
            fill(R, G+randNum, B+randNum, 50);
            strokeWeight(0.1);
            ellipse(sx, sy, psize, psize);
        } 
    }
}

