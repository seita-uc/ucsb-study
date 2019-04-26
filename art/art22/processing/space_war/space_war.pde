import java.util.*; 

class Alien {
    public PImage img;
    public float ax;
    public float ay;
    public float axspeed;
    public float asize;
    public Boolean isShot;
    public long shotTime;

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
        }

        noStroke();
        fill(178, 34, 34);
        ellipse(ax, ay, timePassed/30, timePassed/30);
        fill(255, 140, 0);
        ellipse(ax, ay, timePassed/50, timePassed/50);
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
        translate(mouseX, mouseY);
        rotate(HALF_PI);
        /*fill(255);*/
        /*rect(mouseX, mouseY, 50, 50);*/
        image(img, 0, 0, 50, 50);   
    }

    public void shoot(Alien alien) {
        alien.getShot();
    }
}

int totalAliens = 20;
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
  background(0);
  imageMode(CENTER);
  for(int i = 0; i < aliens.length; i++) {
      aliens[i].invade();
  }
  user.fight();
}

void keyPressed(){
    user.shoot(aliens[int(random(0, aliens.length))]);
} 
