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

    message = new Message(this, msgStr, changeSize);
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
