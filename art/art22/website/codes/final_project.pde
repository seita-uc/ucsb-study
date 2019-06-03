import processing.core.*;
import gifAnimation.*;
import websockets.*;
import java.util.regex.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;
import java.util.TreeMap;
import java.util.Map;
import java.util.Collections;
import java.util.Comparator;
import java.util.concurrent.Semaphore;
import java.math.BigDecimal;
import java.math.MathContext;
import processing.pdf.*; 

HashMap<String, Language> languages = new HashMap<String, Language>();
HashMap<String, WebsocketClient> sockets = new HashMap<String, WebsocketClient>();
String lastLang = null;
HashMap<String, String> endpoints = new HashMap<String, String>();
HashMap<String, String> langList = new HashMap<String, String>();
GifMaker gifExport;

void setup(){
    size(800, 800);
    /*beginRecord(PDF, String.format("images/final_project__%s%s%s%s%s.pdf", month(), day(), hour(), minute(), second()));*/

    PFont font = createFont("Yu Gothic", 64, true);
    textFont(font);

    gifExport = new GifMaker(this, "images/export.gif");
    gifExport.setRepeat(0);				// make it an "endless" animation

    endpoints.put("en", "ws://wikimon.hatnote.com:9000");
    endpoints.put("de", "ws://wikimon.hatnote.com:9010");
    endpoints.put("ru", "ws://wikimon.hatnote.com:9020");
    endpoints.put("uk", "ws://wikimon.hatnote.com:9310");
    endpoints.put("ja", "ws://wikimon.hatnote.com:9030");
    endpoints.put("es", "ws://wikimon.hatnote.com:9040");
    endpoints.put("fr", "ws://wikimon.hatnote.com:9050");
    endpoints.put("nl", "ws://wikimon.hatnote.com:9060");
    endpoints.put("it", "ws://wikimon.hatnote.com:9070");
    endpoints.put("sv", "ws://wikimon.hatnote.com:9080");
    endpoints.put("ar", "ws://wikimon.hatnote.com:9090");
    endpoints.put("fa", "ws://wikimon.hatnote.com:9210");
    endpoints.put("he", "ws://wikimon.hatnote.com:9230");
    endpoints.put("id", "ws://wikimon.hatnote.com:9100");
    endpoints.put("zh", "ws://wikimon.hatnote.com:9240");
    endpoints.put("as", "ws://wikimon.hatnote.com:9150");
    endpoints.put("hi", "ws://wikimon.hatnote.com:9140");
    endpoints.put("bn", "ws://wikimon.hatnote.com:9160");
    endpoints.put("pa", "ws://wikimon.hatnote.com:9120");
    endpoints.put("te", "ws://wikimon.hatnote.com:9165");
    endpoints.put("ta", "ws://wikimon.hatnote.com:9110");
    endpoints.put("ml", "ws://wikimon.hatnote.com:9250");
    endpoints.put("mr", "ws://wikimon.hatnote.com:9130");
    endpoints.put("kn", "ws://wikimon.hatnote.com:9170");
    endpoints.put("or", "ws://wikimon.hatnote.com:9180");
    endpoints.put("sa", "ws://wikimon.hatnote.com:9190");
    endpoints.put("gu", "ws://wikimon.hatnote.com:9200");
    endpoints.put("pl", "ws://wikimon.hatnote.com:9260");
    endpoints.put("mk", "ws://wikimon.hatnote.com:9270");
    endpoints.put("be", "ws://wikimon.hatnote.com:9280");
    endpoints.put("sr", "ws://wikimon.hatnote.com:9290");
    endpoints.put("bg", "ws://wikimon.hatnote.com:9300");
    endpoints.put("hu", "ws://wikimon.hatnote.com:9320");
    endpoints.put("fi", "ws://wikimon.hatnote.com:9330");
    endpoints.put("no", "ws://wikimon.hatnote.com:9340");
    endpoints.put("el", "ws://wikimon.hatnote.com:9350");
    endpoints.put("eo", "ws://wikimon.hatnote.com:9360");
    endpoints.put("pt", "ws://wikimon.hatnote.com:9370");
    endpoints.put("et", "ws://wikimon.hatnote.com:9380");

    langList.put("en", "English");
    langList.put("de", "German");
    langList.put("ru", "Russian");
    langList.put("uk", "Ukrainian");
    langList.put("ja", "Japanese");
    langList.put("es", "Spanish");
    langList.put("fr", "French");
    langList.put("nl", "Dutch");
    langList.put("it", "Italian");
    langList.put("sv", "Swedish");
    langList.put("ar", "Arabic");
    langList.put("fa", "Farsi");
    langList.put("he", "Hebrew");
    langList.put("id", "Indonesian");
    langList.put("zh", "Chinese");
    langList.put("as", "Assamese");
    langList.put("hi", "Hindi");
    langList.put("bn", "Bengali");
    langList.put("pa", "Punjabi");
    langList.put("te", "Telugu");
    langList.put("ta", "Tamil");
    langList.put("ml", "Malayalam");
    langList.put("mr", "Western Mari");
    langList.put("kn", "Kannada");
    langList.put("or", "Oriya");
    langList.put("sa", "Sanskrit");
    langList.put("gu", "Gujarati");
    langList.put("pl", "Polish");
    langList.put("mk", "Macedonian");
    langList.put("be", "Belarusian");
    langList.put("sr", "Serbian");
    langList.put("bg", "Bulgarian");
    langList.put("hu", "Hungarian");
    langList.put("fi", "Finnish");
    langList.put("no", "Norwegian");
    langList.put("el", "Greek");
    langList.put("eo", "Esperanto");
    langList.put("pt", "Portuguese");
    langList.put("et", "Estonian");

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
    gifExport.addFrame();
}

void mousePressed() {
    /*endRecord();*/
    /*exit();*/
    gifExport.finish();
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

class MessageContent {
    public String msg;
    public String code;
    public float size;

    MessageContent(String message, String langCode, float changeSize) {
        msg = message;
        code = langCode;
        size = changeSize;
    }
}

MessageContent parseMessage(String msg) {
    JSONObject msgObj = parseJSONObject(msg);
    String msgStr = msgObj.getString("page_title");
    String url = msgObj.getString("url");
    String langCode = extractLangCode(url);
    if(langCode == "" || validateMsg(msgStr)) {
        return null;
    }

    float changeSize = 20;
    if(!msgObj.isNull("change_size")) {
        changeSize = abs(msgObj.getFloat("change_size"));
    }

    MessageContent content = new MessageContent(msgStr, langCode, changeSize);
    return content;
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

void drawSystem() {
    int totalCircle = endpoints.size()+1;
    for(int i = 0; i < totalCircle; i++) {
        noFill();
        BigDecimal bdWidth = new BigDecimal(width);
        BigDecimal bdEndpointSize = new BigDecimal(totalCircle);
        BigDecimal bdIndex = new BigDecimal(i+1);
        float d = bdWidth
            .divide(bdEndpointSize, MathContext.DECIMAL64)
            .multiply(bdIndex)
            .floatValue();
        float weight = map(i+1, 1, totalCircle, 3, 0);
        stroke(0);
        strokeWeight(weight);
        if(weight == 0) {
            noStroke();
        }
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

class Message {
    public String message;
    public float size;
    public float angle;

    public Message(String msg, float changeSize) {
        message = msg;
        size = changeSize;
    }

    public void show(float x, float y) {
        pushMatrix();
        translate(x, y);

        angle--;
        float rad = radians(angle);
        rotate(rad);

        fill(0, size);
        textSize(3);
        text(message, 0, 0);
        popMatrix();
    }
}
