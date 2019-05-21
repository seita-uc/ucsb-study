import processing.video.*;
import http.requests.*;

GetRequest get = new GetRequest("https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect");
get.addHeader("Ocp-Apim-Subscription-Key", "d86f335d754946b7a54529b6aa4a14b4");
get.send();
println("Response Content: " + get.getContent());
println("Response Content-Length Header: " + get.getHeader("Content-Length"));

Capture cam;
int weight;

void setup() {
  size(1000, 500);

  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);

  /*cam.filter(GRAY);*/
  for(int y = 0; y < height; y += 10){
      for(int x = 0; x < width; x += 5){
          weight = adjustWeight(cam.get(x, y));
          if(weight == 0) {
              continue;
          }
          /*stroke(colors[weight-1]);*/
          strokeWeight(weight);
          line(x, y, x+1, y);
      }
  }
}

int adjustWeight(color c){
    for(int i = 10; i > 0; i--) {
        if(c < -16 * 100000 * i) {
            return i;
        }
    }
    return 0;
}




