    
boolean himmenee = true;
boolean kirkastuu = false;
float vari = 255;
PImage img;
PImage minion;
PImage neulaset;
PImage taustakuva;
PImage kaarna;
PFont fontti;
PImage tausta;
boolean kappaleAloitettu = false;
ArrayList tippuvaLumi = new ArrayList(); //Aloitussivun lunta varten
boolean aloitettu = false; //onko kalenteri aloitettu

import saito.objloader.*;

OBJModel model;
OBJModel model2;
OBJModel model3;
OBJModel model4;
OBJModel luukku;
OBJModel star;
OBJModel kirkko;


OBJModel pallo1;
OBJModel pallo2;
OBJModel pallo3;
OBJModel pallo4;
OBJModel pallo5;


//lumiparametreja
int           depth = 14; 
int           lumipallojenLkm = 1500; //joulumaan lumipallot
Lumisade[]    tabLumisade = new Lumisade[lumipallojenLkm];
Lumisade[]    tabLumisade1 = new Lumisade[lumipallojenLkm];
int           lumiNopeus = 4; //lumen putoamisnopeus
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
  star = new OBJModel(this, "star.obj", "relative", TRIANGLES); 
  kirkko = new OBJModel(this, "kirkko.obj", "relative", TRIANGLES); 
  pallo1 = new OBJModel(this, "pallo1.obj", "relative", TRIANGLES);
  pallo2 = new OBJModel(this, "pallo2.obj", "relative", TRIANGLES);
  pallo3 = new OBJModel(this, "pallo3.obj", "relative", TRIANGLES);
  pallo4 = new OBJModel(this, "pallo4.obj", "relative", TRIANGLES);
  pallo5 = new OBJModel(this, "pallo5.obj", "relative", TRIANGLES);
  img = loadImage("snow.jpg");
  neulaset = loadImage("neulaset.jpg");
  minion = loadImage("tausta.jpg");
  taustakuva = loadImage("taustakuva2.jpg");
  kaarna = loadImage("kaarna.jpg");
  tausta = loadImage("taustakuva.jpg");

  fontti = loadFont("BookAntiqua-Bold-48.vlw");

  for ( int i = 0; i< 60; i++)      // now add some elements for initial seeding 
    CreateChar(1);

  //luodaan joulumaan lumipallot 
  for (int nb=0; nb<lumipallojenLkm; nb++) {
    tabLumisade[nb] = new Lumisade(random(-2*width, 2*width), random(-2*height, 2*height), 
    random(depth*255), random(1, lumiNopeus));
    tabLumisade1[nb] = new Lumisade(random(-2*width, 2*width), random(-2*height, 2*height), 
    random(-depth*255), random(1, lumiNopeus));
  }
  minim = new Minim(this); //soitin
  player = minim.loadFile("Joulumaa.mp3", 2048); //joulukappale
  
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
    for (int i = tippuvaLumi.size()-1; i >= 0; i--) {   // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      lumiAlussa lumialussa = (lumiAlussa) tippuvaLumi.get(i);
      if (lumialussa.eiNakyvissa() ) tippuvaLumi.remove(i);
      else {
        lumialussa.sataa();
        lumialussa.nayta();
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
    if (!kappaleAloitettu) {
       aloitaKappale(); 
    }
    model.disableTexture();
    background(tausta);
    lights();
    //ambientLight(155, 155, 155);
    directionalLight(255, 255, 255, 1, 1, 1);
    //spotLight(255, 255, 255, width/2, height/2, 400, 0, 0, -1, PI/4, 2);

    //translate(width / 2, height / 2);
    rotateY(map(mouseX, 0, width, 0, PI));
    rotateZ(map(mouseY, 0, height, 0, -PI));
    noStroke();

    perspective(PI/3.0, float(width)/float(height), 1, 10000);
    camera( 0, -mouseY-50, mouseY+600, // eyeX, eyeY, eyeZ
    0, 0, 200, // centerX, centerY, centerZ
    0.0, 0.0, 10.0); // upX, upY, upZ
    rotateY( mouseX / 100.0 );
   
    piirraKuusi(0, 0, 0, -250);
    
    
    //piirraKuusi(-100, 0, 0, -230);
      
  //  piirraMetsa(-2800, -2800);
  //  piirraMetsa(-2800, 2800);
  //  piirraMetsa2(-2800, -2800);
  //  piirraMetsa2(2800, -2800);



     piirraNumero();
     
    piirraMaa();

    
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
      piirretaanLahja(-60, 50);
    }
    if (paiva > 4) {  
      piirretaanPossu(900, 600, 0);
    }
    if (paiva > 5) {
      piirretaanLahja(50, 55);
    }
    if (paiva >6) {
      piirretaanPossu(800, 700, 0);
      piirretaanLahja(70, 120);
    }
    if (paiva >7) {
      piirretaanPossu(900, 700, 20);
    }
    
    if (paiva >8) {
      piirraStar();
    }
    
    if (paiva >9) {
      piirraKirkko();

    }
    if (paiva > 10) {
      piirraPallo1(-55, -150, 0);
      piirraPallo2(35, -150, 0);
      piirraPallo3(0, -150, -40);
      piirraPallo4(0, -150, 55);
    }
    if (paiva > 11) {
      piirraPallo2(-40, -80, -45);
      piirraPallo3(-55, -80, 0);
      piirraPallo4(45, -80, 0);
      piirraPallo5(0, -80, -50);
      piirraPallo1(0, -80, 55);
    }
   
    piirraMaa();

}
    
   
    
  }



void piirraMetsa(int x, int z){
  
  int j = 0;
  
  for (int i = 0; i < 20; i++){
    
    piirraKuusi(x + j, 0, z, -250);
    j = j + 280;
  
  }
}
void piirraMetsa2(int x, int z){
  
  int k = 0;
  
  for (int i = 0; i < 20; i++){
    
    piirraKuusi(x , 0, z + k, -250);
    k = k + 280;
  
  }
}

void piirraKuusi(int x, int y, int z, int korkeus1){
    //piirretään kuusi
    pushMatrix();
    translate(x, y, z);
    kappale.piirraKappale1(55, 1, 18, new Point3d(0, korkeus1, 0), new Point3d(0, -160, 0), neulaset); 
    kappale.piirraKappale1(65, 1, 24, new Point3d(0, korkeus1, 0), new Point3d(0, -90, 0), neulaset); 
    kappale.piirraKappale1(70, 1, 35, new Point3d(0, korkeus1, 0), new Point3d(0, -20, 0), neulaset); 
    popMatrix();
  
    //piirretään kuusen runko
    pushMatrix();
    translate(x, y, z);
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
  vertex(2800, 0, 2800, 0, 0);
  vertex(2800, 0, -2800, 0, 1);
  vertex(-2800, 0, -2800, 1, 1);
  vertex(-2800, 0, 2800, 1, 0);
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

void piirretaanPossu(int k, int j, int n) {
  pushMatrix();
  translate(k, 0, j);
  scale(80);
  rotateY(n);
  model.draw();
  popMatrix();
}

void piirretaanLumiukko() {
  pushMatrix();
  translate(600, 0, 150);
  scale(20);
  rotateY(80);
  model2.draw();
  popMatrix();
}
void piirretaanLahja(int j, int k) {
  pushMatrix();
  translate(j, 0, k);
  scale(30);
  model3.draw();
  popMatrix();
}

void piirretaanTalo() {
  pushMatrix();
  translate(800, 0, 100);
  scale(50);
  model4.draw();
  popMatrix();
}

void piirraNumero(){
  
    String luukunnumero = numero.tarkistaPaiva(paiva);
    luukku.load(luukunnumero);
    pushMatrix();
    translate(-100, -200, 140);
    scale(700);
    luukku.draw();
    luukku.reset();
    popMatrix();
}

void piirraStar(){
    pushMatrix();
    translate(-135, -190, 27);
    scale(30);
    star.draw();
    popMatrix();
}

void piirraKirkko(){
    pushMatrix();
    translate(-1000, 0, 500);
    rotateY(40);
    scale(40);
    kirkko.draw();
    popMatrix();

}



void piirraPallo1(int x, int y, int z) {
 pushMatrix();
 translate(x, y, z);
 scale(4);
 pallo1.draw();
 popMatrix();
}

void piirraPallo2(int x, int y, int z) {
 pushMatrix();
 translate(x, y, z);
 scale(3);
 pallo2.draw();
 popMatrix();
}

void piirraPallo3(int x, int y, int z) {
 pushMatrix();
 translate(x, y, z);
 scale(4);
 pallo3.draw();
 popMatrix();
}

void piirraPallo4(int x, int y, int z) {
 pushMatrix();
 translate(x, y, z);
 scale(5);
 pallo4.draw();
 popMatrix();
}

void piirraPallo5(int x, int y, int z) {
 pushMatrix();
 translate(x, y, z);
 scale(3);
 pallo5.draw();
 popMatrix();
}

void aloitaKappale() {
  kappaleAloitettu = true; 
  player.play(); //aloittaa soittamisen 
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
    if (aloitettu && paiva < 24) {
      paiva ++;
    }
    else{
    exit();
    }
  }
}

