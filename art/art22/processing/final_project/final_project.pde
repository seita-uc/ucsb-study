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
    for(Map.Entry<String, String> entry : endpoints.entrySet()) {
        Language lang = new Language(langList.get(entry.getKey()));
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
        if(content == null){
            return;
        }
        Language lang = languages.get(content.code);
        Message message = new Message(content.msg, content.size);
        lang.addMessage(message);
    }
}
