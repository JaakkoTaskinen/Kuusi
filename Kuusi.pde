//<<<<<<< HEAD
boolean himmenee = true;
boolean kirkastuu = false;
float vari = 255;
PImage img;
//=======
import saito.objloader.*;


OBJModel model;

//>>>>>>> 00902b4a74916f2b9bfba1c94ee31651d530a1d5
void setup() {
size(640, 660, P3D);
model = new OBJModel(this, "possu.obj", "relative", TRIANGLES);
img = loadImage("tausta.jpg");
}

void draw() {
 
model.disableTexture();
background(0);
lights();

//translate(width / 2, height / 2);
rotateY(map(mouseX, 0, width, 0, PI));
rotateZ(map(mouseY, 0, height, 0, -PI));
noStroke();

perspective(PI/3.0, float(width)/float(height), 1, 10000);
camera( 0, -mouseY, mouseY+600, // eyeX, eyeY, eyeZ
0, 90, 100, // centerX, centerY, centerZ
0.0, 0.0, 10.0); // upX, upY, upZ
rotateY( mouseX / 100.0 );

//piirretään kuusi
pushMatrix();
translate(0, 0, 0);
fill(0, 105, 0);
piirraKappale(1, 40, 80, 12); 
piirraKappale(1, 45, 130, 12); 
piirraKappale(1, 50, 180, 12); 
popMatrix();

//piirretään kuusen runko
pushMatrix();
translate(0, 180, 0);
fill(139, 69, 19);
piirraKappale(20, 25, 30, 24);
popMatrix();

//piirretään maa
pushMatrix();
translate(0, 210, 0);
fill(255);
piirraKappale(2000, 2000, 1, 60);
popMatrix();


//piirretään paketti
pushMatrix();
translate(0, -20, 0);
if(vari == 190){
 himmenee = false;
 kirkastuu = true;
}
if(vari == 255){
  himmenee = true;
  kirkastuu = false;
}
if (himmenee){
  vari = vari - 1;
}
if(kirkastuu) {
  vari = vari + 1;
}

 fill(vari);
piirraKappale(10, 10, 20, 8); 
popMatrix();

//piirretään possu
    pushMatrix();
    model.enableTexture();
    translate(-100, 210, 50);
    scale(100);
    model.draw();
    popMatrix();
    
    pushMatrix();
    translate(-100, -20, 0);
    fill(100);
    piirraKappale1(1, 100, 6, new Point3d(0, 0, 0), new Point3d(0, 40, 0), img); 
    popMatrix();
}

 void piirraKappale1(float ylaSade, float alaSade, int sivumaara, Point3d ylaKeskipiste, Point3d alaKeskipiste, PImage tekstuuri){
  float kulma1 = 0; 
  float kulma2 = 0; 
  
  int ylaPiste1x = 0;
  int ylaPiste1z = 0;
  int ylaPiste2x = 0;
  int ylaPiste2z = 0;
  int alaPiste1x = 0;
  int alaPiste1z = 0;
  int alaPiste2x = 0;
  int alaPiste2z = 0;
  
  textureMode(NORMAL);
  
  for (int sivunumero = 0; sivunumero < sivumaara; ++sivunumero) {
      kulma1 = sivunumero * 2.0 * PI / sivumaara;
      kulma2 = (sivunumero + 1) * 2.0 * PI / sivumaara;
      println(kulma1);
      println(kulma2);
      
      ylaPiste1x = ylaKeskipiste.x + (int)(sin(kulma1) * ylaSade);
      ylaPiste1z = ylaKeskipiste.z + (int)(cos(kulma1) * ylaSade);
      ylaPiste2x = ylaKeskipiste.x + (int)(sin(kulma2) * ylaSade); 
      ylaPiste2z = ylaKeskipiste.z + (int)(cos(kulma2) * ylaSade); 
      alaPiste1x = ylaKeskipiste.x + (int)(sin(kulma1) * alaSade);
      alaPiste1z = ylaKeskipiste.z + (int)(cos(kulma1) * alaSade); 
      alaPiste2x = ylaKeskipiste.x + (int)(sin(kulma2) * alaSade);
      alaPiste2z = ylaKeskipiste.z + (int)(cos(kulma2) * alaSade);
      
      beginShape();
      texture(tekstuuri);
      
      vertex(ylaPiste2x, ylaKeskipiste.y, ylaPiste2z, 1, 0);
      vertex(ylaPiste1x, ylaKeskipiste.y, ylaPiste1z, 0, 0);
      vertex(alaPiste1x, alaKeskipiste.y, alaPiste1z, 0, 1);
      vertex(alaPiste2x, alaKeskipiste.y, alaPiste2z, 1, 1);
      
      endShape();
      
  }
    
} 

void piirraKappale(float ylaSade, float alaSade, float korkeus, int sivut) {
    float kulma = 0;
    float kulmanKasvu = TWO_PI / sivut;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sivut + 1; ++i) {
      vertex(ylaSade*cos(kulma), 0, ylaSade*sin(kulma));
      vertex(alaSade*cos(kulma), korkeus, alaSade*sin(kulma));
      kulma += kulmanKasvu;
  }
    endShape();

    // If it is not a cone, draw the circular top cap
    if (ylaSade != 0) {
        kulma = 0;
        beginShape(TRIANGLE_FAN);

    // Center point
    vertex(0, 0, 0);
    for (int i = 0; i < sivut + 1; i++) {
        vertex(ylaSade * cos(kulma), 0, ylaSade * sin(kulma));
        kulma += kulmanKasvu;
    }
  endShape();
}

// If it is not a cone, draw the circular bottom cap
if (alaSade != 0) {
  kulma = 0;
  beginShape(TRIANGLE_FAN);

// Center point
  vertex(0, korkeus, 0);
  for (int i = 0; i < sivut + 1; i++) {
    vertex(alaSade * cos(kulma), korkeus, alaSade * sin(kulma));
    kulma += kulmanKasvu;
}
  endShape();
}
}

