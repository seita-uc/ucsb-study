void fillArrays() {
    for(int i = 0; i < totals; i++) {
        x[i] = random(width);
        y[i] = random(height);
        speed[i] = random(speedMin, speedMax);
        limit[i] = random(limitMin, limitMax);
        particleX[i] = 0.0;
        println("Particle: ", i, "Limit: ", limit[i]);
    }
}

void showSystem() {
    for(int i = 0; i < totals; i++) {
        stroke(255);
        line(x[i], y[i], x[i]+limit[i], y[i]);

        particleX[i] += speed[i];

        fill(255);
        ellipse(x[i]+particleX[i], y[i], 5, 5);

        if(particleX[i] > limit[i]) {
            x[i] = random(width);
            y[i] = random(height);
            speed[i] = random(speedMin, speedMax);
            limit[i] = random(limitMin, limitMax);
            particleX[i] = 0.0;
        }
        
        if(i > 0) {
          line(x[i]+ particleX[i], y[i], x[i-1] + particleX[i-1], y[i-1]);
        }     
    }
    
}
