class Alien {
    public float ax;
    public float ay;
    public float axspeed;
    public float asize;

    public Alien() {
        initialize();
    }

    public void invade() {
        ax -= axspeed;
        fill(255);
        ellipse(ax, ay, asize, asize);

        if(ax < 0) {
            ax = width;
        }
    }

    public void initialize() {
        ax = width;
        ay = random(0, 800);
        axspeed = random(1, 5);
        asize = random(10, 30);
    }

    public void die() {
        initialize();
    }
}

class User {
    public User() {
        //initialize();
    }

    public void fight() {
        noStroke();
        fill(random(255), random(255), random(255));
        ellipse(mouseX, mouseY, 20, 20);
    }
}


int totalAliens = 100;
Alien[] aliens = new Alien[totalAliens];
User user = new User();
void setup(){
  size(800, 800);
  for(int i = 0; i < totalAliens; i++) {
      aliens[i] = new Alien();
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
    /*if(key != ' ') {*/
        /*for(int i = 0; i < people.length; i++) {*/
            /*people[i].changeSize(random(100, 300));*/
        /*}*/
    /*}*/
    if(key == ' ') saveFrame("images/people-######.png");
} 
