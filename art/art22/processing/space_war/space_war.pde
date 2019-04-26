import java.util.*; 

class Alien {
    public PImage img;
    public float ax;
    public float ay;
    public float axspeed;
    public float asize;
    public Boolean isShot;
    public long shotTime;
    public float particleX;
    public float particleY;

    public Alien() {
        initialize();
    }

    public void initialize() {
        img = loadImage("images/space_invader_" + int(random(1, 6)) + ".png");
        ax = width;
        ay = random(0, 800);
        axspeed = random(1, 5);
        asize = random(20, 30);
        isShot = false;
    }

    public void invade() {
        if(isShot) {
            explode();
        } else {
            ax -= axspeed;
            image(img, ax, ay, asize, asize);

            if(ax < 0) {
                ax = width;
            }
        }
    }

    public void explode() {
        Date d = new Date();
        long timePassed = d.getTime() - shotTime;

        if(timePassed > 1000) {
            initialize();
        }

        if(timePassed > 0 && timePassed < 500) {
            float weight = 500/timePassed;
            strokeWeight(weight);
            stroke(255,255,0);
            line(mouseX, mouseY, ax, ay);
            noStroke();
            fill(255,255,0);
            ellipse(ax, ay, asize, asize);
        }

        noStroke();
        fill(178, 34, 34);
        float explosionSize = timePassed / 30 + asize;
        ellipse(ax, ay, explosionSize, explosionSize);
        fill(255, 140, 0);
        float explosionCoreSize = timePassed/50;
        ellipse(ax, ay, explosionCoreSize, explosionCoreSize);
    }

    public void getShot() {
        Date d = new Date();
        isShot = true;
        shotTime = d.getTime();
    }
}

class User {
    public PImage img;

    public User() {
        img = loadImage("images/user.png");
    }

    public void fight() {
        imageMode(CENTER);
        noStroke();
        //translate(mouseX, mouseY);
        //rotate(HALF_PI);
        image(img, 0, 0, 50, 50);   
    }

    public void fire(Alien alien) {
        alien.getShot();
    }
}

int totalAliens = 1;
Alien[] aliens = new Alien[totalAliens];
User user;
void setup(){
  size(800, 800, FX2D);
  for(int i = 0; i < totalAliens; i++) {
      aliens[i] = new Alien();
  }
  user = new User();
} 

void draw(){
  //background(0);
  imageMode(CENTER);
  for(int i = 0; i < aliens.length; i++) {
      aliens[i].invade();
  }
  user.fight();
}

void keyPressed(){
    for(int i = 0; i < aliens.length; i++) {
        int randNum = int(random(i, aliens.length));
        if(!aliens[randNum].isShot) {
            user.fire(aliens[randNum]);
            lineFunction(mouseX, mouseY, aliens[randNum].ax, aliens[randNum].ay, 50);
            break;
        }
    }
} 

void lineFunction(float px, float  py, float qx, float qy, int prog) {
    /*for(int i = 0; i < width; i++) {*/
        /*for(int j = 0; j < height; j++) {*/
            /*py == px * i + j;*/
            /*qy == qx * i + j;*/
        /*}*/  
    /*}*/
    float ry = py - qy;
    float rx = px - qx;
    float a = ry / -rx;
    println("ry:", ry);
    println("rx:", rx);
    println("a:", a);
    float xdiff = px - qx;
    println("diff:", xdiff);
    float x = -xdiff * prog / 100;
    println("x:", x);
    float y =   a * x;
    println("y:", y);
    fill(255);
    println("mousex:", mouseX);
    println("mousey:", mouseY);
    println("ax:", qx);
    println("ay:", qy);
    float resx = mouseX + x;
    float resy = mouseY - y;
    println("resx:", resx);      
    println("resy:", resy);
    ellipse(int(resx), int(resy), 200, 200);
    ellipse(100, 100, 20, 20);
    
}   
