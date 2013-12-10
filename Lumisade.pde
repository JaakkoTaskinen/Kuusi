//Luokka lumisateelle
class Lumisade {
  float x, y, z;
  float dY;
   
  Lumisade(float coordX, float coordY, float coordZ, float speedY) {
    x  = coordX; 
    y  = coordY; 
    z  = coordZ; 
    dY = speedY;
  }
   
  //lumipallot 
  void aff() {
    strokeWeight(5);
    stroke(250+z/depth,transparency);
    point(x,y,z);
    noStroke();
  }
  
  void lumiAnimaatio() {
    y = y + dY;
    if( y >= 1100)
      y = -1100;
  }
}
