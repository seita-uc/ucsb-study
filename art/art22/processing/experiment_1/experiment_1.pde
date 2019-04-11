float x = 400;
float y = 300;

class Particle {
    public float px;
    public float py;
    public color pc;

    public Particle(float x, float y, color c) {
        px = x;
        py = y;
        pc = c;
    }

    public void move() {
        px = px + random(-5, 5);
        py = py + random(-5, 5);
        fill(pc);
        ellipse(x, y, 15, 15);
    }
}

void setup() {
    size(800, 800);
    background(225);
}

void draw() {
    Particle p = new Particle(10, 10, color(random(100)));
    p.move();
}
