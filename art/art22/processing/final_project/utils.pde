import java.util.HashMap;
import java.util.Map;

Map<String, String> endpoints = new HashMap<String, String>() {
    {
        put("en", "ws://wikimon.hatnote.com:9000");
        put("de", "ws://wikimon.hatnote.com:9010");
        put("ru", "ws://wikimon.hatnote.com:9020");
        put("uk", "ws://wikimon.hatnote.com:9310");
        put("ja", "ws://wikimon.hatnote.com:9030");
        put("es", "ws://wikimon.hatnote.com:9040");
        put("fr", "ws://wikimon.hatnote.com:9050");
        /*put("nl", "ws://wikimon.hatnote.com:9060");*/
        /*put("it", "ws://wikimon.hatnote.com:9070");*/
        /*put("sv", "ws://wikimon.hatnote.com:9080");*/
        /*put("ar", "ws://wikimon.hatnote.com:9090");*/
        /*put("fa", "ws://wikimon.hatnote.com:9210");*/
        /*put("he", "ws://wikimon.hatnote.com:9230");*/
        /*put("id", "ws://wikimon.hatnote.com:9100");*/
        /*put("zh", "ws://wikimon.hatnote.com:9240");*/
        /*put("as", "ws://wikimon.hatnote.com:9150");*/
        /*put("hi", "ws://wikimon.hatnote.com:9140");*/
        /*put("bn", "ws://wikimon.hatnote.com:9160");*/
        /*put("pa", "ws://wikimon.hatnote.com:9120");*/
        /*put("te", "ws://wikimon.hatnote.com:9165");*/
        /*put("ta", "ws://wikimon.hatnote.com:9110");*/
        /*put("ml", "ws://wikimon.hatnote.com:9250");*/
        /*put("mr", "ws://wikimon.hatnote.com:9130");*/
        /*put("kn", "ws://wikimon.hatnote.com:9170");*/
        /*put("or", "ws://wikimon.hatnote.com:9180");*/
        /*put("sa", "ws://wikimon.hatnote.com:9190");*/
        /*put("gu", "ws://wikimon.hatnote.com:9200");*/
        /*put("pl", "ws://wikimon.hatnote.com:9260");*/
        /*put("mk", "ws://wikimon.hatnote.com:9270");*/
        /*put("be", "ws://wikimon.hatnote.com:9280");*/
        /*put("sr", "ws://wikimon.hatnote.com:9290");*/
        /*put("bg", "ws://wikimon.hatnote.com:9300");*/
        /*put("hu", "ws://wikimon.hatnote.com:9320");*/
        /*put("fi", "ws://wikimon.hatnote.com:9330");*/
        /*put("no", "ws://wikimon.hatnote.com:9340");*/
        /*put("el", "ws://wikimon.hatnote.com:9350");*/
        /*put("eo", "ws://wikimon.hatnote.com:9360");*/
        /*put("pt", "ws://wikimon.hatnote.com:9370");*/
        /*put("et", "ws://wikimon.hatnote.com:9380");*/
    }
};

Map<String, String> langList = new HashMap<String, String>() {
    {
        put("en", "English");
        put("de", "German");
        put("ru", "Russian");
        put("uk", "Ukrainian");
        put("ja", "Japanese");
        put("es", "Spanish");
        put("fr", "French");
        put("nl", "Dutch");
        put("it", "Italian");
        put("sv", "Swedish");
        put("ar", "Arabic");
        put("fa", "Farsi");
        put("he", "Hebrew");
        put("id", "Indonesian");
        put("zh", "Chinese");
        put("as", "Assamese");
        put("hi", "Hindi");
        put("bn", "Bengali");
        put("pa", "Punjabi");
        put("te", "Telugu");
        put("ta", "Tamil");
        put("ml", "Malayalam");
        put("mr", "Western Mari");
        put("kn", "Kannada");
        put("or", "Oriya");
        put("sa", "Sanskrit");
        put("gu", "Gujarati");
        put("pl", "Polish");
        put("mk", "Macedonian");
        put("be", "Belarusian");
        put("sr", "Serbian");
        put("bg", "Bulgarian");
        put("hu", "Hungarian");
        put("fi", "Finnish");
        put("no", "Norwegian");
        put("el", "Greek");
        put("eo", "Esperanto");
        put("pt", "Portuguese");
        put("et", "Estonian");
    }
};

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
