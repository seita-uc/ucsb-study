class Person {
    public PImage img;
    public float px;
    public float py;
    public float pxspeed;
    public float pyspeed;
    public Boolean isOn;
    public float psize;

    public Person(String imgPath, float x, float y, float xspeed, float yspeed) {
        img = loadImage(imgPath);
        px = x;
        py = y;
        pxspeed = xspeed;
        pyspeed = yspeed;
        isOn = true;
        psize = random(100, 300);
    }

    public void walk() {
        if(isOn) {
            image(img, px, py, psize, psize);
        }
        
        px = px + pxspeed;
        py = py + pyspeed;

        if(px > 800) {
            pxspeed = -pxspeed;
        } else if (px < 0) {
            pxspeed = -pxspeed;
        }

        if(py > 800) {
            pyspeed = -pyspeed;
        } else if (py < 0) {
            pyspeed = -pyspeed;
        }
    }

    public void changeSize(float size) {
        psize = size;
    }
}

Person[] people = new Person[10];
void setup(){
  size(800, 800, FX2D);
  background(255);
  for(int i = 0; i < 10; i++) {
      String imgPath = String.format("images/people_%d.png", i+1);
      float x = random(0, 800);
      float y = random(0, 800);
      float xspeed = random(-15, 15);
      float yspeed = random(-15, 15);
      people[i] = new Person(imgPath, x, y, xspeed, yspeed);
  }
} 

void draw(){
  imageMode(CENTER);
  for(int i = 0; i < people.length; i++) {
      people[i].walk();
  }
}


void keyPressed(){
 /*if(key == '1') y1 = random(height);*/
 /*if(key == '2') x2 = random(width);*/
 /*if(key == '4') isItOn1 = !isItOn1;*/
 /*if(key == '5') isItOn2 = !isItOn2;*/
 /*if(key == '6') isItOn3 = !isItOn3;*/
 /*if(key == ' ') saveFrame("line-######.png");*/
} 
