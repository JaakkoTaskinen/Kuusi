//luo alussa olevan lumisateen

int maxKoko = 14;
String graphicsMode =  P2D; 

class lumiAlussa {
  int mx;
  float my;
  int mAlpha;
  float koko;
  float kaanna;
  int lumiPisteet;
  //constructor
  lumiAlussa(int x, int y){
    mx = x;
    my = y;
    mAlpha = 255;
    koko = random(maxKoko);
    kaanna = random(TWO_PI);
    lumiPisteet = 5 + (int)random(5);
  }

  boolean eiNakyvissa() {
    if (my < 0) {
      return false;
    }
    else
      return (my > height) || (mAlpha < 0)  || (koko < 1.5);
  }

  void nayta(){
    if (!eiNakyvissa()) {
      fill(color(255, 255, 255), mAlpha);
      pushMatrix();
      translate(mx - koko /2, my - koko /2);
      rotate(kaanna);
      lumiTahti(lumiPisteet, koko, koko/4);
      popMatrix();
    }
  }

  void sataa(){
    mAlpha = mAlpha - 1;
    my = my + 1 + koko / 5;
    koko = koko * 0.99;
  }
}

void CreateChar(int n){
  int x = (int)random(width);
  int y = (int)random(height/ n);
  if (n == 1) { 
    tippuvaLumi.add(new lumiAlussa(x, y)); 
  }
  else { 
  tippuvaLumi.add(new lumiAlussa(x, -y));
  }  
}


void lumiTahti(int pisteet, float rad1, float rad2){
  float kulma1 = TWO_PI / pisteet;
  float kulma2 = kulma1 / 2;
  float alkupKulma = 0.0;
  beginShape();
  fill(255, 255, 255);
  stroke(255, 255, 255);
  strokeWeight(1);
  for (int i = 0; i < pisteet; i++) {
    float y1 = rad1 * sin(alkupKulma);
    float x1 = rad1 * cos(alkupKulma);
    float y2 = rad2 * sin(alkupKulma + kulma2);
    float x2 = rad2 * cos(alkupKulma + kulma2);
    vertex(x1, y1);
    vertex(x2, y2);
    alkupKulma += kulma1;
  }
  endShape(CLOSE);
}

