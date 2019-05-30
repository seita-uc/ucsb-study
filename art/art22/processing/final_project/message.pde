class Message {
    public String message;
    public float size;
    public float angle;

    public Message(String msg, float changeSize) {
        message = msg;
        size = changeSize;
    }

    public void show(float x, float y) {
        pushMatrix();
        translate(x, y);

        angle++;
        float c = radians(angle);
        rotate(c);

        //drawCircle(0, 0, size);
        fill(255);
        textSize(10);
        text(message, 0, 0);
        popMatrix();
    }

    public void drawCircle(float x, float y, float size) {
        for(float deg = 0; deg < 360; deg += 0.5) {
            float rad = radians(deg);
            float r = size;
            float rcos = r * cos(rad);
            float rsin = r * sin(rad);
            fill(255);
            noStroke();
            ellipse(x + rcos, y + rsin, 5, 5);
        }
    }
}
