import java.util.concurrent.Semaphore;
import java.util.Iterator;
import java.util.ArrayList;
import processing.core.*;

class Language {
    public PApplet p;
    public String lang;
    public Semaphore semaphore = new Semaphore(1);
    public ArrayList<Message> messages = new ArrayList<Message>();
    public float x;
    public float y;
    public float noiseX;
    public float noiseY;
    public float variationX;
    public float variationY;

    public Language(PApplet parent, String langCode) {
        p = parent;
        lang = langCode;
        noiseX = p.random((float)-0.001, (float)0.001);
        noiseY = p.random((float)-0.001, (float)0.001);
        variationX = p.random(1, 100);
        variationY = p.random(1, 100);
    }

    public void addMessage(Message msg) {
        try {
            semaphore.acquire();
            messages.add(msg);
            semaphore.release();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void visualize() {
        try {
            semaphore.acquire();
            variationX += noiseX;
            variationY += noiseY;
            x = p.noise(variationX) * p.width;
            y = p.noise(variationY) * p.height;
            for(Iterator it = messages.iterator(); it.hasNext();) {
                Message msg = (Message)it.next();

                msg.show(x, y);
            }
            semaphore.release();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
