import processing.core.*;

class Message {
    public PApplet p;
    public String message;
    public float size;
    public float angle;

    public Message(PApplet parent, String msg, float changeSize) {
        p = parent;
        message = msg;
        size = changeSize;
    }

    public void show(float x, float y) {
        p.pushMatrix();
        p.translate(x, y);

        angle++;
        float c = p.radians(angle);
        p.rotate(c);

        //drawCircle(0, 0, size);
        p.fill(255);
        p.textSize(10);
        p.text(message, 0, 0);
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
