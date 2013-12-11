//piirtaa erilaisia kappaleita maailmaan, esim. kuusi ja sen runko

class Kappale {

//PImage neulat = loadImage("neula.jpg");
  
void piirraKappale1(float alaSade, float ylaSade, int sivumaara, 
Point3d ylaKeskipiste, Point3d alaKeskipiste, PImage tekstuuri) {
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
} 
}
