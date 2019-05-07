// the image to asciify
PImage img;
 
// sampling resolution: colors will be sampled every n pixels 
// to determine which character to display
int resolution = 9;
 
// array to hold characters for pixel replacement
char[] ascii;
 
void setup() {
  img = loadImage("images/FH010033.JPG");
  println(img.width);
  size(1000, 1000);
  background(0);
  fill(0);
  noStroke();
 
  // build up a character array that corresponds to brightness values
  ascii = new char[256];
  String letters = "AE@Sti:,. ";
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }
 
  fill(255);
  PFont mono = createFont("Courier", resolution + 2);
  textFont(mono);
 
  asciify();
  /*size(img.width, img.height);*/
}
 
void asciify() {
  // since the text is just black and white, converting the image
  // to grayscale seems a little more accurate when calculating brightness
  img.filter(GRAY);
  img.loadPixels();
 
  // grab the color of every nth pixel in the image
  // and replace it with the character of similar brightness
  for (int y = 0; y < img.height; y += resolution) {
    for (int x = 0; x < img.width; x += resolution) {
      color pixel = img.pixels[y * img.width + x];
      /*println(int(brightness(pixel)));*/
      /*if(int(brightness(pixel)) < 25) {*/
          /*continue;*/
      /*}*/
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}
