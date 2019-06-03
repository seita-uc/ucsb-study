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

        angle--;
        float rad = radians(angle);
        rotate(rad);

        fill(0, size);
        textSize(10);
        text(message, 0, 0);
        popMatrix();
    }
}
