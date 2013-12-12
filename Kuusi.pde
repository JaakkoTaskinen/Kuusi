
boolean himmenee = true;
boolean kirkastuu = false;
float vari = 255;
PImage img;
PImage minion;
PImage neulat;
PImage taustakuva;
PImage kaarna;
PFont fontti;


ArrayList fallingChars = new ArrayList();  // Create an empty ArrayList;

boolean aloitettu = false;

import saito.objloader.*;

OBJModel model;
OBJModel model2;
OBJModel model3;
OBJModel model4;
OBJModel luukku;

//lumiparametreja
int           depth = 14; 
int           lumipallojenLkm = 1500; 
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
Numero numero;


void setup() {

  size(640, 660, P3D);
  kappale = new Kappale();
  numero = new Numero();
  model = new OBJModel(this, "possu.obj", "relative", TRIANGLES);
  model2 = new OBJModel(this, "lumiukko.obj", "relative", TRIANGLES);
  model3 = new OBJModel(this, "lahja2.obj", "relative", TRIANGLES);
  model4 = new OBJModel(this, "talo_punainen.obj", "relative", TRIANGLES);
  luukku = new OBJModel(this, "numb1.obj", "relative", TRIANGLES); 
  img = loadImage("lumi.jpg");
  neulat = loadImage("neula.jpg");
  minion = loadImage("tausta.jpg");
  taustakuva = loadImage("tausta.jpg");

  kaarna = loadImage("kaarna.jpg");

  fontti = loadFont("BookAntiqua-Bold-48.vlw");

  for ( int i = 0; i< 60; i++)      // now add some elements for initial seeding 
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
    for (int i = fallingChars.size()-1; i >= 0; i--) {   // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      fallingStar fc = (fallingStar) fallingChars.get(i);
      if (fc.notVisible() ) fallingChars.remove(i);
      else {
        fc.fall();
        fc.display();
      }
    }
    if ((frameCount & 2) > 0 ) {
      int x = (int)random(4);
      for (int j = 0; j < x; j++) {
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

    piirraKuusi();
    piirraMaa();
    piirraNumero(); 
    
    //piirretaan lunta:
    if (paiva > 1) {
      piirretaanLunta();
    }
    
    if (paiva > 2) {
        piirretaanTalo();
    }
    
    //tarkistaPaiva();

    //piirretään possu
    if (paiva > 3) {
      piirretaanLumiukko();
      piirretaanLahja2();
    }
    if (paiva > 4) {  
      piirretaanPossu();
    }
    if (paiva > 5) {
      piirretaanLahja();
    }
    if (paiva >6) {
      piirretaanPossu2();
      piirretaanLahja3();
    }
    if (paiva >7) {
      piirretaanPossu3();
    }
  }
}

void piirraKuusi() {
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
  kappale.piirraKappale1(20, 15, 20, new Point3d(0, -30, 0), new Point3d(0, 0, 0), kaarna);
  popMatrix();
}
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

void piirretaanLunta() {
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
}

/*
void piirretaanPaketti() {
  pushMatrix();
  translate(-210, 0, 0);
  /* if (vari == 190) {
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
}
*/

void piirretaanPossu() {
  pushMatrix();
  model.enableTexture();
  translate(900, 0, 600);
  scale(80);
  model.draw();
  popMatrix();
}

void piirretaanPossu2() {
  pushMatrix();
  model.enableTexture();
  translate(800, 0, 700);
  scale(80);
  rotateY(20);
  model.draw();
  popMatrix();
}

void piirretaanPossu3() {
  pushMatrix();
  model.enableTexture();
  translate(900, 0, 700);
  scale(80);
  rotateY(180);
  model.draw();
  popMatrix();
}

void piirretaanLumiukko() {
  pushMatrix();
  model2.enableTexture();
  translate(600, 30, 150);
  scale(20);
  rotateY(80);
  model2.draw();
  popMatrix();
}
void piirretaanLahja() {
  pushMatrix();
  model3.enableTexture();
  translate(55, 0, 50);
  scale(30);
  model3.draw();
  popMatrix();
}

void piirretaanLahja2() {
  pushMatrix();
  model3.enableTexture();
  translate(70, 0, 85);
  scale(30);
  model3.draw();
  popMatrix();
}

void piirretaanLahja3() {
  pushMatrix();
  model3.enableTexture();
  translate(-60, 0, 50);
  scale(30);
  model3.draw();
  popMatrix();
}

void piirretaanTalo() {
  pushMatrix();
  model4.enableTexture();
  translate(800, 50, 100);
  scale(50);
  model4.draw();
  popMatrix();
}

void piirraNumero(){
    String luukunnumero = numero.tarkistaPaiva(paiva);
    luukku = new OBJModel(this, luukunnumero, "relative", TRIANGLES);
    pushMatrix();
    luukku.enableTexture();
    translate(-60, -300, -20);
    scale(500);
    luukku.draw();
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

