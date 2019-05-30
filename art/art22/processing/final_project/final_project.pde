import processing.core.*;
import websockets.*;
import java.util.regex.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.HashMap;
import java.util.Map;

Map<String, Language> languages = new HashMap<String, Language>();
Map<String, WebsocketClient> sockets = new HashMap<String, WebsocketClient>();

void setup(){
    size(800, 800);
    String url = "ws://wikimon.hatnote.com:9000";
    for(Map.Entry<String, String> entry : endpoints.entrySet()) {
        Language lang = new Language(this, entry.getKey());
        languages.put(entry.getKey(), lang);
        WebsocketClient socket = new WebsocketClient(this, entry.getValue());
        sockets.put(entry.getKey(), socket);
    }
}

void draw(){
    background(0);

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
        Language lang = languages.get(content.langCode);
        Message message = new Message(this, content.msg, content.changeSize);
        lang.addMessage(message);
    }
}
