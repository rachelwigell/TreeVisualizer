public class Polygon {
  int sides;
  float radius;
  Vector3D RGBcolor;
  Vector3D[] vertices;
  
  public Polygon(int sides, float radius){
    this.sides = sides;
    this.radius = radius;
    this.RGBcolor = new Vector3D(255, 255, 255);
    final double changeOfAngle = 2 * PI / this.sides;
    double angle = 0;
    vertices = new Vector3D[sides];
    for(int i = 0; i < this.sides; i++){
      vertices[i] = (new Vector3D(0, radius * Math.cos(angle), radius * Math.sin(angle)));
      angle += changeOfAngle;
    }
  }
  
  public void drawPolygon(){
    pushMatrix();
    fill(this.RGBcolor.x, this.RGBcolor.y, this.RGBcolor.z);
    beginShape();
    for(int i = 0; i < this.sides; i++){
      Vector3D vertex = vertices[i];
      vertex(0, vertex.y, vertex.z);
    }
    endShape();
    popMatrix();
  }
}