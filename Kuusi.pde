
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
OBJModel model4;
OBJModel luukku;
OBJModel star;
OBJModel kirkko;
OBJModel laatikko;
OBJModel lippu;
OBJModel kynttila;
OBJModel kuusiT;
OBJModel ulkotuli;
OBJModel tonttu;
OBJModel pukki;

OBJModel lahja1;
OBJModel lahja2;
OBJModel lahja3;
OBJModel lahja4;

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
  lahja1 = new OBJModel(this, "lahja1.obj", "relative", TRIANGLES);
  lahja2 = new OBJModel(this, "lahja2.obj", "relative", TRIANGLES);
  lahja3 = new OBJModel(this, "lahja3.obj", "relative", TRIANGLES);
  lahja4 = new OBJModel(this, "lahja4.obj", "relative", TRIANGLES);
  model4 = new OBJModel(this, "talo_punainen.obj", "relative", TRIANGLES);
  luukku = new OBJModel(this, "numb1.obj", "relative", TRIANGLES);
  star = new OBJModel(this, "star.obj", "relative", TRIANGLES); 
  laatikko = new OBJModel(this, "boxi.obj", "relative", TRIANGLES);
  kirkko = new OBJModel(this, "kirkko.obj", "relative", TRIANGLES);
  lippu = new OBJModel(this, "lippu.obj", "relative", TRIANGLES); 
  pallo1 = new OBJModel(this, "pallo1.obj", "relative", TRIANGLES);
  pallo2 = new OBJModel(this, "pallo2.obj", "relative", TRIANGLES);
  pallo3 = new OBJModel(this, "pallo3.obj", "relative", TRIANGLES);
  pallo4 = new OBJModel(this, "pallo4.obj", "relative", TRIANGLES);
  pallo5 = new OBJModel(this, "pallo5.obj", "relative", TRIANGLES);
  kynttila = new OBJModel(this, "kynttila.obj", "relative", TRIANGLES);
  kuusiT = new OBJModel(this, "kuusi.obj", "relative", TRIANGLES);
  ulkotuli = new OBJModel(this, "ulkokynttila.obj", "relative", TRIANGLES);
  tonttu = new OBJModel(this, "tonttu.obj", "relative", TRIANGLES);
  pukki = new OBJModel(this, "pukki.obj", "relative", TRIANGLES);

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

    //piirretaan lunta:
    if (paiva > 1) {
      piirretaanLunta();
    }

    if (paiva > 2) {
      piirraMalli(800, 0, 100, model4, 50, -200);
      piirraMalli(-1000, 0, 500, kirkko, 40, 40);
    }

    if (paiva > 3) {
      piirraMalli(1100, 0, -500, kuusiT, 50, 10);
      piirraMalli(900, 0, -400, kuusiT, 50, 20);
    }

    if (paiva > 4) {
      piirraMalli(600, 0, 150, model2, 20, 80); 
    }

    if (paiva > 5) {
      piirraMalli(-200, 9, -500, lippu, 25, 0); 
      piirraMalli(100, 0, 700, kuusiT, 50, 10); 
      piirraMalli(-100, 0, 900, kuusiT, 50, 20);
    }

    if (paiva >6) { 
      piirraMalli(-900, 0, 200, kynttila, 250, 0); 
    }

    if (paiva >7) {
      piirraMalli(900, 0, 600, model, 80, 0); 
      piirraMalli(50, 0, -55, lahja2, 10, 0); 
      piirraMalli(-50, 0, 55, lahja2, 10, 0); 
    }

    if (paiva >8) {
      piirraMalli(-500, 0, 600, kuusiT, 50, 10); 
      piirraMalli(-600, 0, 700, kuusiT, 50, 20);  
  }

    if (paiva >9) {
      piirraMalli(900, 0, 700, model, 80, 200); 
    }

    if (paiva > 10) {
      piirraMalli(-920, 0, 190, kynttila, 250, 0); 
      piirraMalli(20, 0, -40, lahja3, 20, 0); 
      piirraMalli(-150, 0, 30, lahja3, 25, 0); 
      piirraMalli(20, 0, 40, lahja3, 30, 0); 
    }

    if (paiva > 11) {
      piirraMalli(-700, 0, -800, kuusiT, 50, 10); //tavinen kuusi
      piirraMalli(-600, 0, -850, kuusiT, 50, 20); //tavinen kuusi
    }

    if (paiva > 12) {
      piirraMalli(70, 0, 80, lahja2, 15, 0); //lahja
      piirraMalli(-70, 0, 100, lahja2, 15, 0); //lahja
    }

    if (paiva > 13) {
      piirraMalli(-1100, 0, -100, kuusiT, 50, 10); //tavinen kuusi
      piirraMalli(-1200, 0, -250, kuusiT, 50, 20); //tavinen kuusi  
    }

    if (paiva > 14) {
      piirraMalli(800, 0, 700, model, 70, -100); //possu
      piirraMalli(-55, -150, 0, pallo1, 3, 0);
      piirraMalli(35, -150, 0, pallo2, 3, 0);
      piirraMalli(0, -150, -40, pallo3, 4, 0);
      piirraMalli(0, -150, 55, pallo4, 5, 0);
    
    }

    if (paiva > 15) {
      piirraMalli(-880, 0, 220, kynttila, 250, 0); //kynttilä
    } 
    if (paiva > 16) {
      piirraMalli(-200, 0, 100, lahja4, 30, 0);
      piirraMalli(-80, 0, - 60, lahja4, 30, 0);
    } 
    if (paiva > 17) {
      piirraMalli(-400, 0, 100, ulkotuli, 80, 0);   
    } 
    if (paiva > 18) {
      piirraMalli(0, -80, 55, pallo1, 3, 0);
      piirraMalli(-55, -80, 0, pallo3, 3, 0);
      piirraMalli(-40, -80, -45, pallo2, 4, 0);
      piirraMalli(45, -80, 0, pallo4, 5, 0);
      piirraMalli(0, -80, -50, pallo5, 3, 0);
    } 
    if (paiva > 19) {
      piirraMalli(-800, 0, 300, tonttu, 80, 40);
      piirraMalli(-940, 0, 170, kynttila, 250, 0);
    } 
    if (paiva > 20) {  
      piirraMalli(-300, 0, -350, ulkotuli, 80, 0);   
      piirraMalli(500, 0, 120, ulkotuli, 90, 0);   
    } 
    if (paiva > 21) {
       piirraMalli(-800, 0, 0, tonttu, 80, 20);
    } 
    if (paiva > 22) {
      piirraMalli(-135, -190, 27, star, 30, 0); 
    } 
    if (paiva > 23) {
      piirraMalli(-500, -40, 100, pukki, 80, 0);
    } 
 
    piirraPaketti();
    piirraMaa();
  }
}

void piirraKuusi(int x, int y, int z, int korkeus1) { //piirretään kuusi
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

void piirraPaketti() {
  pushMatrix();
  translate(-300, -200, -200);
  laatikko.draw();
  popMatrix();
}

void piirraMalli(int x, int y, int z, OBJModel malli, int skaala, int rotaatio) {
  pushMatrix();
  translate(x, y, z);
  scale(skaala);
  rotateY(rotaatio);
  malli.draw();
  popMatrix();
}

void piirraNumero() {
  String luukunnumero = numero.tarkistaPaiva(paiva);
  luukku.load(luukunnumero);
  pushMatrix();
  translate(-100, -300, 140);
  scale(600);
  luukku.draw();
  luukku.reset();
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
    else {
      exit();
    }
  }
}

