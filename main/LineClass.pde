
public class Line {
  Vector3D start;
  Vector3D end;
  Polygon startFace;
  Polygon endFace;
  float length;
  
  public Line(Vector3D start, Vector3D end){
    this.start = start;
    this.end = end;
    this.length = end.distance(start);
  }
  
  public Line(Vector3D start, Vector3D end, Polygon startFace, Polygon endFace){
    this.start = start;
    this.end = end;
    this.length = end.distance(start);
    this.startFace = startFace;
    this.endFace = endFace;
  }
  
  public void drawSolid(){
    fill(255);
    noStroke();
    float xDiff = (this.end.x-this.start.x);
    float yDiff = (this.end.y-this.start.y);
    float zDiff = (this.end.z-this.start.z);
    float yAngle = asin(yDiff/this.length);
    float xzAngle = -atan(zDiff/xDiff);
    if(xDiff < 0) yAngle *= -1;
    pushMatrix();
      translate(this.start.x,
           this.start.y,
           this.start.z);
      rotateY(xzAngle);
      rotateZ(yAngle);
      this.startFace.drawPolygon();
      Vector3D[] startVertices = new Vector3D[startFace.sides];
      for(int i = 0; i < startFace.sides; i++){
        Vector3D vertex = startFace.vertices[i];
        startVertices[i] = new Vector3D(modelX(vertex.x, vertex.y, vertex.z), modelY(vertex.x, vertex.y, vertex.z), modelZ(vertex.x, vertex.y, vertex.z));
      }
    popMatrix();
    pushMatrix();
      translate(this.end.x,
           this.end.y,
           this.end.z);
      rotateY(xzAngle);
      rotateZ(yAngle);
      this.endFace.drawPolygon();
      Vector3D[] endVertices = new Vector3D[endFace.sides];
      for(int i = 0; i < endFace.sides; i++){
        Vector3D vertex = endFace.vertices[i];
        endVertices[i] = new Vector3D(modelX(vertex.x, vertex.y, vertex.z), modelY(vertex.x, vertex.y, vertex.z), modelZ(vertex.x, vertex.y, vertex.z));
      }
    popMatrix();
    for(int i = 0; i < startFace.sides-1; i++){
      beginShape();
      vertex(startVertices[i].x, startVertices[i].y, startVertices[i].z);
      vertex(startVertices[i+1].x, startVertices[i+1].y, startVertices[i+1].z);
      vertex(endVertices[i+1].x, endVertices[i+1].y, endVertices[i+1].z);
      vertex(endVertices[i].x, endVertices[i].y, endVertices[i].z);
      endShape(CLOSE);
    }
    beginShape();
    vertex(startVertices[startFace.sides-1].x, startVertices[startFace.sides-1].y, startVertices[startFace.sides-1].z);
    vertex(startVertices[0].x, startVertices[0].y, startVertices[0].z);
    vertex(endVertices[0].x, endVertices[0].y, endVertices[0].z);
    vertex(endVertices[endFace.sides-1].x, endVertices[endFace.sides-1].y, endVertices[endFace.sides-1].z);
    endShape(CLOSE); 
  }
  
  public void drawLine(){
    noFill();
    stroke(255);
    line(start.x, start.y,  start.z, end.x, end.y, end.z);
  }
  
  public void drawBox(){
    fill(255);
    noStroke();
    pushMatrix();
    float xDiff = (this.end.x-this.start.x);
    float yDiff = (this.end.y-this.start.y);
    float zDiff = (this.end.z-this.start.z);
    translate(this.start.x+(xDiff)/2,
             this.start.y+(yDiff)/2,
             this.start.z+(zDiff)/2);
    float xzAngle = -atan(zDiff/xDiff);
    rotateY(xzAngle);
    float yAngle = asin(yDiff/this.length);
    if(xDiff < 0) yAngle *= -1;
    rotateZ(yAngle);
    scale(1, .01+1/this.length, .01+1/this.length);
    box(this.length);
    popMatrix();
  }
  
  public Vector3D getPointWithThisY(float y){
    float percent = (y-start.y)/(end.y-start.y);
    float x = percent*(end.x-start.x)+start.x;
    float z = percent*(end.z-start.z)+start.z;
    return new Vector3D(x, y, z);
  }
}