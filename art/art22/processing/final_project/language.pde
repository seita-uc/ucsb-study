import java.util.concurrent.Semaphore;
import java.util.Iterator;
import java.util.ArrayList;

class Language implements Comparable<Language> {
    public Semaphore semaphore = new Semaphore(1);
    public ArrayList<Message> messages = new ArrayList<Message>();
    public float x;
    public float y;
    /*public float noiseX;*/
    /*public float noiseY;*/
    /*public float variationX;*/
    /*public float variationY;*/
    public float size;
    public String name;
    public float angle;
    public int rank = 1;
    public int weight = 0;

    public Language(String langName) {
        name = langName;
        angle = random(0, 360);
        /*noiseX = random((float)-0.001, (float)0.001);*/
        /*noiseY = random((float)-0.001, (float)0.001);*/
        /*variationX = random(1, 100);*/
        /*variationY = random(1, 100);*/
    }

    public int compareTo(Language lang) {
        if (this.weight <= lang.getWeight()) {
            return 1;
        } else {
            return -1;
        }
    }

    public void addMessage(Message msg) {
        try {
            semaphore.acquire();
            messages.add(msg);
            weight = messages.size();
            semaphore.release();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void changeRank(int newRank) {
        rank = newRank;
    }

    public int getWeight() {
        return weight;
    }

    public void visualize() {
        angle++;
        float rad = radians(angle);
        /*float r = width/8*(i+1);*/
        float r = width/(endpoints.size()*2)*rank;
        float rcos = r * cos(rad);
        float rsin = r * sin(rad);
        x = width/2 + rcos;
        y = height/2 + rsin;

        try {
            semaphore.acquire();

            /*variationX += noiseX;*/
            /*variationY += noiseY;*/
            /*x = noise(variationX) * width;*/
            /*y = noise(variationY) * height;*/

            textAlign(CENTER);
            fill(0);
            textSize(10);
            text(name, x, y);

            for(Iterator it = messages.iterator(); it.hasNext();) {
                Message msg = (Message)it.next();
                textAlign(LEFT);
                msg.show(x, y);
            }
            semaphore.release();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
