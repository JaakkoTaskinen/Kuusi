
//musiikkia varten parametreja
import ddf.minim.*; //musiikkisoitinkirjasto
AudioPlayer player; //soitin
Minim minim;

//lumiparametreja
int           depth = 14; 
int           lumipallojenLkm = 3500; 
Lumisade[]    tabLumisade = new Lumisade[lumipallojenLkm];
int           lumiNopeus = 7;
boolean       clearScreen = true;
int           taille = 1;
int           transparency = 255;
int           rotationMode = 3; //ei hajuakaan mikä tää on?!
float         angle = 0;
float         delta = radians(0.25);


void setup() {
  size(640, 660, P3D);
  String strX, strY;
  colorMode(RGB,255);
  //lumipallojen luominen
  for(int nb=0; nb<lumipallojenLkm; nb++) {
    tabLumisade[nb] = new Lumisade(random(-2*width,2*width),random(-2*height,2*height),
                               -random(depth*255),random(1,lumiNopeus));
  }
  minim = new Minim(this); //soitin
  player = minim.loadFile("joululaulu.wav", 2048); //joulukappale
  player.play(); //aloittaa soittamisen
}

void draw() {
  background(0);
  lights();
  //translate(width / 2, height / 2);
  rotateY(map(mouseX, 0, width, 0, PI));
  rotateZ(map(mouseY, 0, height, 0, -PI));
  noStroke();
  fill(0, 105, 0);
  perspective(PI/3.0, float(width)/float(height), 1, 10000);
  camera( 0, -mouseY, mouseY+600, // eyeX, eyeY, eyeZ
  0, 90, 100, // centerX, centerY, centerZ
  0.0, 0.0, 10.0); // upX, upY, upZ
  //rotateY( mouseX / 100.0 );
  /*translate(width/2+((mouseX-(width/2))*10)/(width/2),
            height/2+((mouseY-(height/2))*10)/(height/2),
            0);*/
  rotateY(-((mouseX-(width/2))*radians(30))/(width/2));
  if(rotationMode==1) {
    angle += delta;
  }
  if(rotationMode==2) {
    angle -= delta;
  }
  rotateZ(angle);
  for(int nb=0; nb<lumipallojenLkm; nb++) {
    tabLumisade[nb].aff();
    tabLumisade[nb].lumiAnimaatio();
  } 

 translate(0, 60, 0);
  drawCylinder(1, 40, 80, 12); 
  drawCylinder(1, 45, 130, 12); 
  drawCylinder(1, 50, 180, 12); 
  
  //piirraKappale(200, 200, 200, 4);

}

/*void piirraKappale(float topRadius, float bottomRadius, float tall, int sides) {
  float angle = 0;
    float angleIncrement = TWO_PI / sides;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sides + 1; ++i) {
      vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
      vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
      angle += angleIncrement;
  }
    endShape();
}*/

void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sides + 1; ++i) {
      vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
      vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
      angle += angleIncrement;
  }
    endShape();

    // If it is not a cone, draw the circular top cap
    if (topRadius != 0) {
        angle = 0;
        beginShape(TRIANGLE_FAN);

    // Center point
    vertex(0, 0, 0);
    for (int i = 0; i < sides + 1; i++) {
        vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
        angle += angleIncrement;
    }
  endShape();
}

// If it is not a cone, draw the circular bottom cap
if (bottomRadius != 0) {
  angle = 0;
  beginShape(TRIANGLE_FAN);

// Center point
  vertex(0, tall, 0);
  for (int i = 0; i < sides + 1; i++) {
    vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
    angle += angleIncrement;
}
  endShape();
}
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}




