float halfWidth; 
float halfHeight; 
WaterParticle[] particles = new WaterParticle[3000];

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
    /*for(int i = 0; i < particles.length; i++) { */
        /*particles[i].move();*/
    /*}*/
    for(int i = 0; i < particles.length; i++) { 
        particles[i].move();
    }
}

void keyPressed(){
    if(key == '1') saveFrame("images/water_fountain_######.jpg");
} 

class WaterParticle {
    public float wx;
    public float wy;
    public float wxSpeed;
    public float wySpeed;
    public float wSize;
    public color wColor;
    public float wOpacity;
    public float wyAdjustor;
    public Boolean isGoingUp;

    public WaterParticle() {
        initialize(true);
    }

    public void initialize(Boolean isFirst) {
        if (isFirst) {
            wy = random(height, height + 1500);
        } else {
            wy = random(height, height + 1500);
        }
        isGoingUp = true;
        wx = halfWidth + random(-20, 20);
        wxSpeed = random(-5, 5);
        wySpeed = random(-12, -5);
        wSize = random(3, 15);
        float randNum = random(0, 120);
        wColor = color(randNum, randNum, random(125, 255));
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
            initialize(false);
        } else if (!isGoingUp && wy > height) {
            initialize(false);
        }

        if(isGoingUp) {
            wy += wySpeed;
        } else {
            wx += wxSpeed;
            wySpeed += 0.7 ;
            wOpacity -= 2.5;
        }
        wy += wySpeed;
    }
}
