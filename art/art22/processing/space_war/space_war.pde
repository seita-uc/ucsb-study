import java.util.*; 

class Alien {
    public PImage img;
    public float ax;
    public float ay;
    public float axspeed;
    public float asize;
    public int aid;
    public Boolean isShot;
    public long shotTime;

    public Alien(int id) {
        aid = id;
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

        if(timePassed > 1500) {
            initialize();
        }

        if(timePassed > 0 && timePassed < 500) {
            float weight = 500/timePassed;
            println(weight);
            strokeWeight(weight);
            stroke(255,255,0);
            line(mouseX, mouseY, ax, ay);
        }

        noStroke();
        fill(178, 34, 34);
        ellipse(ax, ay, timePassed/30, timePassed/30);
    }

    public void getShot() {
        Date d = new Date();
        isShot = true;
        shotTime = d.getTime();
    }
}

class User {
    public float r;
    public float g;
    public float b;

    public User() {
        r = random(255);
        g = random(255);
        b = random(255);
    }

    public void fight() {
        noStroke();
        fill(r, g, b);
        ellipse(mouseX, mouseY, 20, 20);
    }

    public void shoot(Alien alien) {
        stroke(255);
        alien.getShot();
    }
}


int totalAliens = 50;
Alien[] aliens = new Alien[totalAliens];
User user = new User();
void setup(){
  size(800, 800, FX2D);
  for(int i = 0; i < totalAliens; i++) {
      aliens[i] = new Alien(i);
  }
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
