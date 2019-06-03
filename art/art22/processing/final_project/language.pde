import java.util.concurrent.Semaphore;
import java.util.Iterator;
import java.util.ArrayList;
import java.math.BigDecimal;
import java.math.MathContext;

class Language implements Comparable<Language> {
    public Semaphore semaphore = new Semaphore(1);
    public ArrayList<Message> messages = new ArrayList<Message>();
    public float x;
    public float y;
    public float size;
    public String name;
    public String code;
    public float angle;
    public float speed;
    public int rank = 1;
    public int weight = 0;

    public Language(String langName, String langCode) {
        name = langName;
        code = langCode;
        angle = random(0, 360);
        speed = random(0.1, 2);
    }

    public int compareTo(Language lang) {
        if (this.weight < lang.getWeight()) {
            return 1;
        } else if (this.weight > lang.getWeight()) {
            return -1;
        }
        return 0;
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

    public void connectWithLine(Language lang) {
        stroke(0);
        strokeWeight(0.5);
        line(x, y, lang.x, lang.y);
    }

    public void visualize() {
        angle += speed;
        float rad = radians(angle);
        int totalCircle = endpoints.size()+1;
        BigDecimal bdWidth = new BigDecimal(width);
        BigDecimal bdEndpointSize = new BigDecimal(totalCircle);
        BigDecimal bdTwo = new BigDecimal(2);
        BigDecimal bdRank = new BigDecimal(rank);
        BigDecimal d = bdWidth
            .divide(bdEndpointSize, MathContext.DECIMAL64);
        float r = d
            .divide(bdTwo, MathContext.DECIMAL64)
            .multiply(bdRank)
            .floatValue();
        float rcos = r * cos(rad);
        float rsin = r * sin(rad);
        x = width/2 + rcos;
        y = height/2 + rsin;

        try {
            semaphore.acquire();
            textAlign(CENTER);
            fill(0);
            ellipse(x, y, 3, 3);
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
