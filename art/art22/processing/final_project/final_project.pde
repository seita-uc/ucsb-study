import websockets.*;
import java.util.regex.*;
import java.util.ArrayList;
import java.util.Iterator;

WebsocketClient wsc;
Message message;
ArrayList<Message> messages = new ArrayList<Message>();

void setup(){
    size(1000, 1000);
    wsc= new WebsocketClient(this, "ws://wikimon.hatnote.com:9000");
}

void draw(){
    background(0);
    for(Iterator it = messages.iterator(); it.hasNext();) {
        Message msg = (Message)it.next();
        msg.show();
    }
    if(frameCount % 60 == 0) {
        wsc.sendMessage("Ping");
    }
}

void webSocketEvent(String msg){
    textSize(10);
    if(msg != "") {
        JSONObject msgObj = parseJSONObject(msg);
        String msgStr = msgObj.getString("page_title");
        if(!msgObj.isNull("change_size")) {
            float changeSize = msgObj.getFloat("change_size");
            /*println(changeSize);*/
            /*textSize(abs(changeSize));*/
        }
        String regex = "^User|^Special:Log";
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(msgStr);
        if (m.find()) {
            return;
        }
        message = new Message(msgStr);
        messages.add(message);
    }
}

class Message {
    public String message;
    public float mx;
    public float my;

    public Message(String msg) {
        message = msg;
        mx = random(0, width);
        my = random(0, height);
    }

    public void show() {
        fill(255);
        text(message, mx, my);
        if(random(100) > 50) {
            mx += noise(mx);
            my += noise(my);
        } else {
            mx -= noise(mx);
            my -= noise(my);
        }
    }
}


