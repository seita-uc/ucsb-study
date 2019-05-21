import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer song;
FFT fft;
float y = 100;
String[] chars = {
  "あ",
  "い",
  "う",
  "え",
  "お",
  "か",
  "き",
  "く",
  "け",
  "こ",
  "さ",
  "し",
  "す",
  "せ",
  "そ",
  "た",
  "ち",
  "つ",
  "て",
  "と",
  "な",
  "に",
  "ぬ",
  "ね",
  "の",
};
Char[] voices;

void setup() {
    size(800, 800);
    background(0);

    PFont font = createFont("Yu Gothic", 64, true);
    textFont(font);

    minim = new Minim(this);
    song = minim.loadFile("data/city_noise.mp3", 1024);
    song.loop();

    voices = new Char[song.bufferSize()-1];
    for(int i = 0; i < song.bufferSize() - 1; i++) {
        stroke(0, random(1, 60));
        float x1 = map(i, 0, song.bufferSize(), 0, width);
        float waveHeight = map(song.left.get(i+1), -1, 1, -height, height);
        voices[i] = new Char(i, x1, height/2-waveHeight);
        voices[i].show();
    }
}

void draw() {
    fill(0, 10);
    noStroke();
    rect(0, 0, width, height);
    for(int i = 0; i < voices.length; i++) {
        voices[i].show();
    }
}

void mousePressed() {
    background(255);
}

class Char {
    public float cx;
    public float cy;
    public int cindex;

    public Char(int i, float x, float y) {
        cx = x;
        cy = y;
        cindex = i;
    }

    public void show() {
        textSize(13);
        fill(255);
        if(random(100)>80) fill(0);;
        text(chars[int(random(chars.length-1))], cx, cy);

        float hoge = map(song.left.get(cindex), -1, 1, -height/2, height/2);
        cy += hoge;
    }
}

