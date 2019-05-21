import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
Oscil[] wave;
float[] vol;
float[] freqs;

void startSound() {
    minim = new Minim(this);
    out = minim.getLineOut();
    wave = new Oscil[rows];
    vol = new float[rows];
    freqs = new float[rows];

    for(int i = 0; i < rows; i++) {
        vol[i] = 0.0;
        wave[i] = new Oscil(440, 0.5f, Waves.SINE);
        wave[i].setAmplitude(vol[i]);
        float thisFreq = map(table.getInt(i, 1), 0, 10, 200, 700);
        wave[i].setFrequency(thisFreq);
        wave[i].patch(out);
    }
}

void checkSound() {
    for(int i = 0; i < rows; i++) {
        if(dist(mouseX, mouseY, x[i], height/2) < 10) {
            animatedSize[i] = 0;
            vol[i] += 0.1;
            if(vol[i] < 0.8) vol[i] = 0.8; 
        } else {
            vol[i] -= 0.1;
            if(vol[i] < 0) vol[i] = 0; 
        }
        wave[i].setAmplitude(vol[i]);
    }
}
