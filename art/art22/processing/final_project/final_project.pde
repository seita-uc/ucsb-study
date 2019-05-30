import processing.core.*;
import websockets.*;
import java.util.regex.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.concurrent.Semaphore;

WebsocketClient wsc;
WebsocketClient wsc_2;
Message message;
ArrayList<Message> messages = new ArrayList<Message>();
Semaphore msgSemaphore = new Semaphore(1);
Semaphore matrixSemaphore = new Semaphore(1);

void setup(){
    size(1000, 1000);
    String url = "ws://wikimon.hatnote.com:9000";
    wsc= new WebsocketClient(this, url);
}

void draw(){
    background(0);

    /*Language english = new Language(this, "ws://wikimon.hatnote.com:9000");*/
    try {
        msgSemaphore.acquire();
        for(Iterator it = messages.iterator(); it.hasNext();) {
            Message msg = (Message)it.next();
            msg.show();
        }
        msgSemaphore.release();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }

    if(frameCount % 60 == 0) {
        wsc.sendMessage("Ping");
    }
}

void webSocketEvent(String msg){
    textSize(10);
    if(msg != "") {
        parseMessage(msg);
    }
}

void parseMessage(String msg) {
    JSONObject msgObj = parseJSONObject(msg);
    String msgStr = msgObj.getString("page_title");
    String url = msgObj.getString("url");
    String countryCode = extractCountryCode(url);
    if(countryCode == "" || validateMsg(msgStr)) {
        return;
    }

    float changeSize = 20;
    if(!msgObj.isNull("change_size")) {
        changeSize = abs(msgObj.getFloat("change_size"));
    }

    message = new Message(msgStr, changeSize);
    try {
        msgSemaphore.acquire();
        messages.add(message);
        msgSemaphore.release();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
}

String extractCountryCode(String url) {
    String regex = "^https://(..).wikipedia.org.*";
    Pattern p = Pattern.compile(regex);
    if(url != null) {
        Matcher m = p.matcher(url);
        if (m.find()) {
            String countryCode = m.group(1);
            println(countryCode);
            return countryCode;
        }
    }
    return "";
}

Boolean validateMsg(String msg) {
    if(msg == "") {
        return true;
    }
    String regex = "^User|^Special:Log";
    Pattern p = Pattern.compile(regex);
    Matcher m = p.matcher(msg);
    return m.find();
}

public class Language {
    public String message;
    public float size;
    public float mx;
    public float my;
    public PApplet parent;
    public WebsocketClient socket;
    public Semaphore msgSemaphore = new Semaphore(1);
    public ArrayList<Message> messages = new ArrayList<Message>();

    public Language(PApplet parent, String url) {
        /*"ws://wikimon.hatnote.com:9000"*/
        /*this.parent = parent;*/
        /*this.parent.getClass().webSocketEvent = this.visualize;*/
        socket = new WebsocketClient(this.parent, url);
        /*socket.sendMessage("Ping");*/
    }

    public void visualize() {
        for(Iterator it = messages.iterator(); it.hasNext();) {
            Message msg = (Message)it.next();
            pushMatrix();
            msg.show();
            popMatrix();
        }
    }
    
    public void webSocketEvent(String msg) {
        println(msg);
    }
}

class Message {
    public String message;
    public float size;
    public float mx;
    public float my;
    public float mnoiseX;
    public float mnoiseY;
    public float mvariationX;
    public float mvariationY;

    public Message(String msg, float changeSize) {
        message = msg;
        size = changeSize;
        mx = random(0, width);
        my = random(0, height);
        mnoiseX = random(0.001, 0.01);
        mnoiseY = random(0.001, 0.01);
        mvariationX = random(1, 100);
        mvariationY = random(1, 100);
    }

    public void show() {
        pushMatrix();
        translate(width/2, 0);
        rotate(radians(45));
        mvariationX += mnoiseX;
        mvariationY += mnoiseY;
        mx = noise(mvariationX) * width;
        my = noise(mvariationY) * height;
        println(noise(mvariationY) * height);
        drawCircle(mx, my, size);
        fill(255);
        text(message, mx, my);
        popMatrix();
    }
}

void drawCircle(float x, float y, float size) {
    for(float deg = 0.0; deg < 360; deg += 0.5) {
        float rad = radians(deg);
        float r = size;
        float rcos = r * cos(rad);
        float rsin = r * sin(rad);
        fill(255);
        noStroke();
        ellipse(x + rcos, y + rsin, 5, 5);
    }
}

