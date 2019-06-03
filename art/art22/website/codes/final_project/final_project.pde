import processing.core.*;
import websockets.*;
import java.util.regex.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.Map;
import java.util.Collections;
import java.util.Comparator;
import java.math.BigDecimal;
import java.math.MathContext;
import processing.pdf.*; 

Map<String, Language> languages = new HashMap<String, Language>();
Map<String, WebsocketClient> sockets = new HashMap<String, WebsocketClient>();
String lastLang = null;

void setup(){
    size(800, 800);
    /*beginRecord(PDF, String.format("images/final_project__%s%s%s%s%s.pdf", month(), day(), hour(), minute(), second()));*/

    PFont font = createFont("Yu Gothic", 64, true);
    textFont(font);

    for(Map.Entry<String, String> entry : endpoints.entrySet()) {
        String langCode = entry.getKey();
        Language lang = new Language(langList.get(langCode), langCode);
        languages.put(entry.getKey(), lang);
        WebsocketClient socket = new WebsocketClient(this, entry.getValue());
        sockets.put(entry.getKey(), socket);
    }
}

void draw(){
    background(255);
    drawSystem();

    /*fill(255, 5);*/
    /*noStroke();*/
    /*rect(0, 0, width, height);*/

    reflectRanksOfLanguages();

    for(Map.Entry<String, Language> entry : languages.entrySet()) {
        Language lang = entry.getValue();
        lang.visualize();
        if(lastLang != null) {
            lang.connectWithLine(languages.get(lastLang));
        }
        lastLang = lang.code;
    }

    if(frameCount % 60 == 0) {
        for(Map.Entry<String, WebsocketClient> entry : sockets.entrySet()) {
            WebsocketClient socket = entry.getValue();
            socket.sendMessage("ping");
        }
    }
}

void mousePressed() {
    /*endRecord();*/
    /*exit();*/
}

void webSocketEvent(String msg){
    if(msg != "") {
        MessageContent content = parseMessage(msg);
        if(content == null){
            return;
        }
        Language lang = languages.get(content.code);
        Message message = new Message(content.msg, content.size);
        lang.addMessage(message);
    }
}
