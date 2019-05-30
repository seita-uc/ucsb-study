import java.util.concurrent.Semaphore;
import java.util.Iterator;
import java.util.ArrayList;

class Language {
    public Semaphore semaphore = new Semaphore(1);
    public ArrayList<Message> messages = new ArrayList<Message>();
    public float x;
    public float y;
    public float noiseX;
    public float noiseY;
    public float variationX;
    public float variationY;
    public String name;

    public Language(String langName) {
        name = langName;
        noiseX = random((float)-0.001, (float)0.001);
        noiseY = random((float)-0.001, (float)0.001);
        variationX = random(1, 100);
        variationY = random(1, 100);
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
            x = noise(variationX) * width;
            y = noise(variationY) * height;
            textAlign(CENTER);
            text(name, x, y);
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
