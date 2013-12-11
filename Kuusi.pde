
boolean himmenee = true;
boolean kirkastuu = false;
float vari = 255;
PImage img;
PImage minion;
PImage neulat;
PImage taustakuva;
PFont fontti;

ArrayList fallingChars = new ArrayList();  // Create an empty ArrayList;

boolean aloitettu = false;

import saito.objloader.*;

OBJModel model;
OBJModel model2;
OBJModel model3;
OBJModel model4;
OBJModel numero;

//lumiparametreja
int           depth = 14; 
int           lumipallojenLkm = 3500; 
Lumisade[]    tabLumisade = new Lumisade[lumipallojenLkm];
Lumisade[]    tabLumisade1 = new Lumisade[lumipallojenLkm];
int           lumiNopeus = 7;
boolean       clearScreen = true;
int           taille = 1;
int           transparency = 255;
int           rotationMode = 3; 
float         angle = 0;
float         delta = radians(0.25);
//musiikkia varten parametreja
import ddf.minim.*; //musiikkisoitinkirjasto
AudioPlayer player; //soitin
Minim minim;
int paiva = 0;
Kappale kappale;


void setup() {

  size(640, 660, P3D);
  kappale = new Kappale();
  model = new OBJModel(this, "possu.obj", "relative", TRIANGLES);
  model2 = new OBJModel(this, "lumiukko.obj", "relative", TRIANGLES);
  model3 = new OBJModel(this, "lahja2.obj", "relative", TRIANGLES);
  model4 = new OBJModel(this, "talo_punainen.obj", "relative", TRIANGLES);
  numero = new OBJModel(this, "numb1.obj", "relative", TRIANGLES); 
  img = loadImage("lumi.jpg");
  neulat = loadImage("neula.jpg");
  minion = loadImage("tausta.jpg");
  taustakuva = loadImage("taustakuva2.jpg");
  fontti = loadFont("BookAntiqua-Bold-48.vlw");
  
  for( int i = 0; i< 60; i++)      // now add some elements for initial seeding 
    CreateChar(1);

  for (int nb=0; nb<lumipallojenLkm; nb++) {
    tabLumisade[nb] = new Lumisade(random(-2*width, 2*width), random(-2*height, 2*height), 
    random(depth*255), random(1, lumiNopeus));
    tabLumisade1[nb] = new Lumisade(random(-2*width, 2*width), random(-2*height, 2*height), 
    random(-depth*255), random(1, lumiNopeus));
  }
  minim = new Minim(this); //soitin
  player = minim.loadFile("joululaulu.wav", 2048); //joulukappale
  player.play(); //aloittaa soittamisen
}

void draw() {
  if (!aloitettu) {
    background(255);
    fill(240);
    scale(0.5);
    image(taustakuva, -20, 0);
    scale(1/0.5);
    textFont(fontti, 42);
    textAlign(CENTER);
    text("Tervetuloa Joulumaahan!", 320, 100);
    textFont(fontti, 28);
    text("Joulumaahan ilmestyy joulukalenterin\ntavoin joka päivä jotain uutta,\nkun painat välilyöntiä.\nPeli myös alkaa välilyönnillä.", 320, 180);
    text("Mukavaa Joulun odotusta!", 320, 350);
    
  //  background(0);
  for (int i = fallingChars.size()-1; i >= 0; i--)
  {   // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      fallingStar fc = (fallingStar) fallingChars.get(i);
      if (fc.notVisible() ) fallingChars.remove(i);
      else
      {
        fc.fall();
        fc.display();
      }
  }
  if ((frameCount & 2) > 0 )
  {
    int x = (int)random(4);
    for (int j = 0; j < x; j++)
      {
          CreateChar(4);  // top 1/4th
          CreateChar(8);  // top 1/8th
      }
  }
  }
  else {
  
    model.disableTexture();
    background(0);
    lights();
    //ambientLight(155, 155, 155);
    directionalLight(255, 255, 255, 1, 1, 1);
    //spotLight(255, 255, 255, width/2, height/2, 400, 0, 0, -1, PI/4, 2);
  
  
    //translate(width / 2, height / 2);
    rotateY(map(mouseX, 0, width, 0, PI));
    rotateZ(map(mouseY, 0, height, 0, -PI));
    noStroke();
  
    perspective(PI/3.0, float(width)/float(height), 1, 10000);
    camera( 0, -mouseY - 100, mouseY+600, // eyeX, eyeY, eyeZ
    0, 0, 200, // centerX, centerY, centerZ
    0.0, 0.0, 10.0); // upX, upY, upZ
    rotateY( mouseX / 100.0 );
  
  
    //piirretaan lunta:
    if (rotationMode==1) {
      angle += delta;
    }
    /* if(rotationMode==2) {
     angle -= delta;
     }*/
    rotateZ(angle);
    for (int nb=0; nb<lumipallojenLkm; nb++) {
      tabLumisade[nb].aff();
      tabLumisade[nb].lumiAnimaatio();
    } 
    for (int nb=0; nb<lumipallojenLkm; nb++) {
      tabLumisade1[nb].aff();
      tabLumisade1[nb].lumiAnimaatio();
    } 
  
    //piirretään paketti
    pushMatrix();
    translate(-210, 0, 0);
    if (vari == 190) {
      himmenee = false;
      kirkastuu = true;
    }
    if (vari == 255) {
      himmenee = true;
      kirkastuu = false;
    }
    if (himmenee) {
      vari = vari - 1;
    }
    if (kirkastuu) {
      vari = vari + 1;
    }
  
    fill(vari);
    kappale.piirraKappale1(40, 40, 4, new Point3d(0, -40, 0), new Point3d(0, 0, 0), minion);
    popMatrix();
  
    tarkistaPaiva();
    
    //piirretään possu
    pushMatrix();
    model.enableTexture();
    translate(-100, 0, 50);
    scale(100);
    model.draw();
    popMatrix();
  
    pushMatrix();
    model2.enableTexture();
    translate(-200, 30, 140);
    scale(20);
    model2.draw();
    popMatrix();
  
    pushMatrix();
    model3.enableTexture();
    translate(-200, 0, -100);
    scale(100);
    model3.draw();
    popMatrix();
  
    pushMatrix();
    model4.enableTexture();
    translate(200, 50, 100);
    scale(100);
    model4.draw();
    popMatrix();
  
    //piirretään kuusi
    pushMatrix();
    translate(0, 0, 0);
    kappale.piirraKappale1(60, 1, 20, new Point3d(0, -250, 0), new Point3d(0, -150, 0), neulat); 
    kappale.piirraKappale1(65, 1, 20, new Point3d(0, -250, 0), new Point3d(0, -90, 0), neulat); 
    kappale.piirraKappale1(70, 1, 20, new Point3d(0, -250, 0), new Point3d(0, -20, 0), neulat); 
    popMatrix();
  
    //piirretään kuusen runko
    pushMatrix();
    translate(0, 0, 0);
    fill(139, 69, 19);
    kappale.piirraKappale1(20, 15, 20, new Point3d(0, -30, 0), new Point3d(0, 0, 0), minion);
    popMatrix();
  
    piirraMaa();
  }
}

/*void piirraKappale1(float alaSade, float ylaSade, int sivumaara, Point3d ylaKeskipiste, Point3d alaKeskipiste, PImage tekstuuri) {
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
} */

/*void piirraKappale(float ylaSade, float alaSade, float korkeus, int sivut, PImage tekstuuri) {
 float kulma = 0;
 float kulmanKasvu = TWO_PI / sivut;
 beginShape(QUAD_STRIP);
 for (int i = 0; i < sivut + 1; ++i) {
 texture(tekstuuri);
 vertex(ylaSade*cos(kulma), 0, ylaSade*sin(kulma));
 vertex(alaSade*cos(kulma), korkeus, alaSade*sin(kulma));
 kulma += kulmanKasvu;
 }
 endShape();
 
 // If it is not a cone, draw the circular top cap
 if (ylaSade != 0) {
 kulma = 0;
 beginShape(TRIANGLE_FAN);
 texture(tekstuuri);
 
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
 texture(tekstuuri);
 
 // Center point
 vertex(0, korkeus, 0);
 for (int i = 0; i < sivut + 1; i++) {
 vertex(alaSade * cos(kulma), korkeus, alaSade * sin(kulma));
 kulma += kulmanKasvu;
 }
 endShape();
 }
 }*/

void piirraMaa() {

  //fill(200);
  noFill();
  noTint();
  textureMode(NORMAL);
  beginShape();
  texture(img);
  vertex(1800, 0, 1800, 0, 0);
  vertex(1800, 0, -1800, 0, 1);
  vertex(-1800, 0, -1800, 1, 1);
  vertex(-1800, 0, 1800, 1, 0);
  endShape();
}

public void tarkistaPaiva() {
  switch(paiva) {
  case 1: 
  numero = new OBJModel(this, "numb1.obj", "relative", TRIANGLES); 
  break; 
  case 2: 
  numero = new OBJModel(this, "numb2.obj", "relative", TRIANGLES);
  break; 
  case 3: 
  numero = new OBJModel(this, "numb3.obj", "relative", TRIANGLES);
  break; 
  case 4: 
  numero = new OBJModel(this, "numb4.obj", "relative", TRIANGLES);
  break; 
  case 5: 
 // numero = new OBJModel(this, "numb5.obj", "relative", TRIANGLES);
  break; 
  case 6: 
  numero = new OBJModel(this, "numb6.obj", "relative", TRIANGLES);
  break; 
  case 7:  
  numero = new OBJModel(this, "numb7.obj", "relative", TRIANGLES);
  break; 
  }
  pushMatrix();
  numero.enableTexture();
  translate(-100, -200, 140);
  scale(500);
  numero.draw();
  popMatrix();
  
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}

void keyPressed() {
  if (key == ' ') {
    if (!aloitettu) {
     aloitettu = true; 
    }
    if (aloitettu && paiva < 25) {
      paiva ++;
      println("space bar pressed " + paiva);
    }
  }
}


