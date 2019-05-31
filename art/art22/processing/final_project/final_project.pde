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

Map<String, Language> languages = new HashMap<String, Language>();
Map<String, WebsocketClient> sockets = new HashMap<String, WebsocketClient>();

void setup(){
    size(900, 900);
    PFont font = createFont("Yu Gothic", 64, true);
    textFont(font);

    for(Map.Entry<String, String> entry : endpoints.entrySet()) {
        Language lang = new Language(langList.get(entry.getKey()));
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
    }

    if(frameCount % 60 == 0) {
        for(Map.Entry<String, WebsocketClient> entry : sockets.entrySet()) {
            WebsocketClient socket = entry.getValue();
            socket.sendMessage("ping");
        }
    }
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

void drawSystem() {
    for(int i = 0; i < endpoints.size() + 30; i++) {
        noFill();
        BigDecimal bdWidth = new BigDecimal(width);
        BigDecimal bdEndpointSize = new BigDecimal(endpoints.size());
        BigDecimal bdIndex = new BigDecimal(i+1);
        float d = bdWidth.divide(bdEndpointSize).multiply(bdIndex).floatValue();
        strokeWeight(1);
        ellipse(width/2, height/2, d, d);
    }
}

void reflectRanksOfLanguages() {
    List<Map.Entry<String, Language>> mapOrderList = new ArrayList<Map.Entry<String, Language>>(languages.entrySet());
    Collections.sort(mapOrderList, new ValueListComparator());
    for(int i = 0; i < mapOrderList.size(); i++) {
        Map.Entry<String, Language> entry= mapOrderList.get(i);
        Language lang = entry.getValue();
        lang.changeRank(i+1);
        /*println(i+1 + ": " + lang.name + " " + lang.getWeight());*/
    }
}

static class ValueListComparator
implements Comparator<Map.Entry<String, Language>>{
    public int compare(Map.Entry<String, Language> object1,
            Map.Entry<String, Language> object2){
        Language lang1 = object1.getValue();
        Language lang2 = object2.getValue();
        return lang1.compareTo(lang2);
    }
}

