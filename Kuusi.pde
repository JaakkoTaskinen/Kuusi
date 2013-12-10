//<<<<<<< HEAD
boolean himmenee = true;
boolean kirkastuu = false;
float vari = 255;
PImage img;
PImage neulat;
//=======
import saito.objloader.*;

OBJModel model;
OBJModel model2;
OBJModel model3;
OBJModel model4;

//>>>>>>> 00902b4a74916f2b9bfba1c94ee31651d530a1d5
void setup() {
  size(640, 660, P3D);
  model = new OBJModel(this, "possu.obj", "relative", TRIANGLES);
  model2 = new OBJModel(this, "lumiukko.obj", "relative", TRIANGLES);
  model3 = new OBJModel(this, "lahja2.obj", "relative", TRIANGLES);
  model4 = new OBJModel(this, "talo_punainen.obj", "relative", TRIANGLES);
  img = loadImage("lumi.jpg");
  neulat = loadImage("neula.jpg");


}

void draw() {
 
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
camera( 0, -mouseY, mouseY+600, // eyeX, eyeY, eyeZ
0, 90, 100, // centerX, centerY, centerZ
0.0, 0.0, 10.0); // upX, upY, upZ
rotateY( mouseX / 100.0 );

//piirretään kuusi
pushMatrix();
translate(0, 0, 0);
//fill(0, 105, 0);
piirraKappale(1, 40, 80, 12, neulat); 
piirraKappale(1, 45, 130, 12, neulat); 
piirraKappale(1, 50, 180, 12, neulat); 
popMatrix();

//piirretään kuusen runko
pushMatrix();
translate(0, 180, 0);
fill(139, 69, 19);
piirraKappale(20, 25, 30, 24, img);
popMatrix();

//piirretään maa
pushMatrix();
translate(0, 210, 0);
fill(255);
piirraKappale(2000, 2000, 1, 60, img);
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
  piirraKappale(10, 10, 20, 8, img); 
  popMatrix();

//piirretään possu
    pushMatrix();
    model.enableTexture();
    translate(-100, 210, 50);
    scale(100);
    model.draw();
    popMatrix();
    
    pushMatrix();
    model2.enableTexture();
    translate(200, 210, 50);
    scale(100);
    model2.draw();
    popMatrix();
  
    pushMatrix();
    model3.enableTexture();
    translate(-100, 210, 50);
    scale(300);
    model3.draw();
    popMatrix();  
    
    pushMatrix();
    model4.enableTexture();
    translate(-100, 210, 50);
    scale(100);
    model4.draw();
    popMatrix();  
      
    piirraMaa();

}

void piirraKappale(float ylaSade, float alaSade, float korkeus, int sivut, PImage tekstuuri) {
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
}

void piirraMaa() {
  
 //fill(200);
 noFill();
 noTint();
 textureMode(NORMAL);
 beginShape();
 texture(img);
 vertex(800, 200, 800, 0, 0);
 vertex(800, 200, -800, 0, 1);
 vertex(-800, 200, -800, 1,1);
 vertex(-800, 200, 800, 1, 0);
 endShape(); 
  
  
}



