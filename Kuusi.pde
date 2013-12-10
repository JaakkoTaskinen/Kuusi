//<<<<<<< HEAD
boolean himmenee = true;
boolean kirkastuu = false;
float vari = 255;
//=======
import saito.objloader.*;

OBJModel model;

//>>>>>>> 00902b4a74916f2b9bfba1c94ee31651d530a1d5
void setup() {
size(640, 660, P3D);
model = new OBJModel(this, "possu.obj", "relative", TRIANGLES);
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

