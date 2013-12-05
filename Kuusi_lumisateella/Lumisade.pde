//Luokka lumisateelle
class Lumisade {
  float x, y, z;
  float dZ;
   
  Lumisade(float coordX, float coordY, float coordZ, float speedZ) {
    x  = coordX; 
    y  = coordY; 
    z  = coordZ; 
    dZ = speedZ;
  }
   
  //lumipallot 
  void aff() {
    strokeWeight(5);
    stroke(250+z/depth,transparency);
    point(x,y,z);
    noStroke();
  }
  
  void lumiAnimaatio() {
    z = z + dZ;
    if( z>=0)
      z = -1023.0;
  }
}
