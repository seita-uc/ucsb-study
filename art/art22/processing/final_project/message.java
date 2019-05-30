import processing.core.*;

class Message {
    public PApplet p;
    public String message;
    public float size;
    public float mx;
    public float my;
    public float mnoiseX;
    public float mnoiseY;
    public float mvariationX;
    public float mvariationY;

    public Message(PApplet parent, String msg, float changeSize) {
        p = parent;
        message = msg;
        size = changeSize;
        mx = p.random(0, p.width);
        my = p.random(0, p.height);
        mnoiseX = p.random((float)0.001, (float)0.01);
        mnoiseY = p.random((float)0.001, (float)0.01);
        mvariationX = p.random(1, 100);
        mvariationY = p.random(1, 100);
    }

    public void show() {
        p.pushMatrix();
        p.translate(p.width/2, p.height/2);
        p.rotate(p.radians(p.map(p.second(), 0, 60, 0, 360)));
        mvariationX += mnoiseX;
        mvariationY += mnoiseY;
        mx = p.noise(mvariationX) * p.width;
        my = p.noise(mvariationY) * p.height;
        /*println(noise(mvariationY) * height);*/
        drawCircle(mx, my, size);
        p.fill(255);
        p.text(message, mx, my);
        p.popMatrix();
    }

    public void drawCircle(float x, float y, float size) {
        for(float deg = 0; deg < 360; deg += 0.5) {
            float rad = p.radians(deg);
            float r = size;
            float rcos = r * p.cos(rad);
            float rsin = r * p.sin(rad);
            p.fill(255);
            p.noStroke();
            p.ellipse(x + rcos, y + rsin, 5, 5);
        }
    }
}

