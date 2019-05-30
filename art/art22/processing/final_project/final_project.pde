import processing.core.*;
import websockets.*;
import java.util.regex.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.concurrent.Semaphore;



WebsocketClient wsc;
Language english;
Semaphore msgSemaphore = new Semaphore(1);
Semaphore matrixSemaphore = new Semaphore(1);
Map<String, Language> languages = new HashMap<String, Language>();

void setup(){
    size(800, 800);
    String url = "ws://wikimon.hatnote.com:9000";
    wsc= new WebsocketClient(this, url);
    english = new Language(this, "en");
}

void draw(){
    background(0);

    english.visualize();

    /*try {*/
        /*msgSemaphore.acquire();*/
        /*for(Iterator it = messages.iterator(); it.hasNext();) {*/
            /*Message msg = (Message)it.next();*/

            /*variationX += noiseX;*/
            /*variationY += noiseY;*/
            /*x = noise(variationX) * width;*/
            /*y = noise(variationY) * height;*/

            /*msg.show(x, y);*/
        /*}*/
        /*msgSemaphore.release();*/
    /*} catch (InterruptedException e) {*/
        /*e.printStackTrace();*/
    /*}*/

    if(frameCount % 60 == 0) {
        wsc.sendMessage("Ping");
    }
}

void webSocketEvent(String msg){
    if(msg != "") {
        parseMessage(msg);
    }
}

void parseMessage(String msg) {
    JSONObject msgObj = parseJSONObject(msg);
    String msgStr = msgObj.getString("page_title");
    String url = msgObj.getString("url");
    String langCode = extractLangCode(url);
    if(langCode == "" || validateMsg(msgStr)) {
        return;
    }

    float changeSize = 20;
    if(!msgObj.isNull("change_size")) {
        changeSize = abs(msgObj.getFloat("change_size"));
    }

    Message message = new Message(this, msgStr, changeSize);
    addLangMessage(message);
}

void addLangMessage(Message msg) {
    english.addMessage(msg);
}

String extractLangCode(String url) {
    String regex = "^https://(..).wikipedia.org.*";
    Pattern p = Pattern.compile(regex);
    if(url != null) {
        Matcher m = p.matcher(url);
        if (m.find()) {
            String langCode = m.group(1);
            return langCode;
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
