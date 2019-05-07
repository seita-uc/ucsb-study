float halfWidth; 
float halfHeight; 
WaterFountain fountain1;
/*WaterFountain fountain2;*/
/*WaterFountain fountain3;*/

void setup(){
    size(800, 800);
    background(0);
    halfWidth = width/2;
    halfHeight = height/2;
    fountain1 = new WaterFountain(3000, halfWidth);
    /*fountain2 = new WaterFountain(3000, halfWidth/2);*/
    /*fountain3 = new WaterFountain(3000, width/4*3);*/
}

void draw(){
    background(0);
    fountain1.run();
    /*fountain2.run();*/
    /*fountain3.run();*/
}

void keyPressed(){
    if (key == '1') saveFrame("images/water_fountain_######.jpg");
} 

class WaterFountain {
    public WaterParticle[] particles;

    public WaterFountain(int size, float x) {
        particles = new WaterParticle[size];
        for(int i = 0; i < particles.length; i++) { 
            particles[i] = new WaterParticle(x);
        }
    }

    public void run() {
        for(int i = 0; i < particles.length; i++) { 
            particles[i].move();
        }
    }
}

class WaterParticle {
    public float initx;
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

    public WaterParticle(float x) {
        initialize(x);
    }

    public void initialize(float x) {
        initx = x;
        wy = random(height, height + 1500);
        isGoingUp = true;
        wx = initx + random(-20, 20);
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
            initialize(initx);
        }

        if (wy < height/2 + 100) {
            wr += random(-100, wb - wr);
            wg += random(-100, wb - wg);
            wColor = color(wr, wg ,wb);
        }

        if (isGoingUp) {
            wy += wySpeed;
        } else if (wy > height) {
            initialize(initx);
        } else {
            wx += wxSpeed;
            wySpeed += 0.7 ;
            wOpacity -= 2.5;
        }
        wy += wySpeed;
    }
}
