float halfWidth; 
float halfHeight; 
WaterParticle[] particles = new WaterParticle[5000];

void setup(){
    size(800, 800);
    background(0);
    halfWidth = width/2;
    halfHeight = height/2;
    for(int i = 0; i < particles.length; i++) { 
        particles[i] = new WaterParticle();
    }
}

void draw(){
    background(0);
    for(int i = 0; i < particles.length; i++) { 
        particles[i].move();
    }
}

void keyPressed(){
    if (key == '1') saveFrame("images/water_fountain_######.jpg");
} 

class WaterParticle {
    public float wx;
    public float wy;
    public float wxSpeed;
    public float wySpeed;
    public float wSize;
    public float wr;
    public float wg;
    public float wb;
    public color wColor;
    public float wOpacity;
    public Boolean isGoingUp;

    public WaterParticle() {
        initialize();
    }

    public void initialize() {
        wy = random(height, height + 1500);
        isGoingUp = true;
        wx = halfWidth + random(-20, 20);
        wxSpeed = random(-5, 5);
        wySpeed = random(-12, -5);
        wSize = random(1, 15);
        float randNum = random(0, 120);
        wr = randNum;
        wg = randNum;
        wb = random(125, 255);
        wColor = color(wr, wg ,wb);
        wOpacity = random(20, 255);
    }

    public void move() {
        wy = wy + wySpeed;
        noStroke();
        fill(wColor, wOpacity);
        ellipse(wx, wy, wSize, wSize);

        if (wy < height/2) {
            isGoingUp = false;
        } else if (wy < 0) {
            initialize();
        }

        if (wy < height/2 + 100) {
            wr += random(-100, wb - wr);
            wg += random(-100, wb - wg);
            wColor = color(wr, wg ,wb);
        }

        if (isGoingUp) {
            wy += wySpeed;
        } else if (wy > height) {
            initialize();
        } else {
            wx += wxSpeed;
            wySpeed += 0.7 ;
            wOpacity -= 2.5;
        }
        wy += wySpeed;
    }
}
