
import processing.video.*;
Capture retinacam;
PFont f;
final int pixeler = 4;
int[] time = { 0, 20000, 40000 };

String lineone = "Il pleut des voix de femmes comme si elles étaient mortes même dans le souvenir";
String linetwo = "c’est vous aussi qu’il pleut, merveilleuses rencontres de ma vie. ô gouttelettes"; 
// String linethree = "et ces nuages cabrés se prennent à hennir tout un univers de villes auriculaires";
// String linefour = "écoute s’il pleut tandis que le regret et le dédain pleurent une ancienne musique;"
// String linefive = "écoute tomber les liens qui te retiennent en haut et en bas": 

int[] charx = new int[lineone.length()];
int[] chary = new int[lineone.length()];
int[] charx2 = new int[linetwo.length()];
int[] chary2 = new int[linetwo.length()];

void setup() {
  size(1280, 720);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }
  retinacam = new Capture(this, cameras[0]);
  retinacam.start();
  colorMode(HSB, 255);
  noStroke();
  f = createFont("Futura", 24, true);
  textFont(f);
//
//for (int i = 0; i < linetwo.length(); i++) {
//  chary2[i] = -200;
//}

  charx[0] = 10;
  for (int i=1; i < lineone.length(); i++) {
    charx[i]= charx[i-1] += 15;
    println(textWidth(lineone.charAt(i-1)));
  }
  
    charx2[0] = 10;
  for (int i=1; i < linetwo.length(); i++) {
    charx2[i]= charx2[i-1] += 15;
    println(textWidth(linetwo.charAt(i-1)));
  }
}

void draw() {
  if (retinacam.available()==true) {
    retinacam.read();
  }

 // retinacam.loadPixels();
  int threshold = 60;

  for (int x = 0; x < retinacam.width; x+=pixeler) {
    for (int y = 0; y < retinacam.height; y+=pixeler) {
      int loc = x + y*retinacam.width;
      if (brightness(retinacam.pixels[loc]) > threshold) {
        fill(160, 100, 100);
      }  
      else {
        fill(200, 100, 50);
      }
      rect(x, y, pixeler, pixeler);
    }
  }

  retinacam.updatePixels();

  //image(retinacam, 0, 0);

if( millis() >= time[0] ){
for (int i = 0; i < lineone.length(); i++) {  
if((chary[i] > retinacam.height)||(chary[i]<0)){
     chary[i] = 0;
     }  
     else {
     chary[i] = chary[i] + int((brightness(get(charx[i], chary[i]))-60)/random(10,15));
     }
    fill(112, 250, 180);
    text(lineone.charAt(i), charx[i], chary[i]);
  } 
  }
  
if( millis() >= time[1] ){
  for (int i = 0; i < linetwo.length(); i++) {  
if((chary2[i] > retinacam.height)||(chary2[i]<0)){
     chary2[i] = 0;
     }  
     else {
     chary2[i] = chary2[i] + int((brightness(get(charx2[i], chary2[i]))-60)/random(5,29));
     }
    fill(35, 250, 250);
    text(linetwo.charAt(i), charx2[i], chary2[i]);
  }
}
  
} 

