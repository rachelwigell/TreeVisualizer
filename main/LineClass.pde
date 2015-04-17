
public class Line {
  Vector3D start;
  Vector3D end;
  float length;
  Polygon startFace;
  Polygon endFace;
  
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
  
  public void drawLine(PApplet visual){
    visual.line(start.x, start.y,  start.z, end.x, end.y, end.z);
  }
  
  public void drawSolid(PApplet visual){
    startFace.drawPolygon(visual);
    endFace.drawPolygon(visual);
    int numVert = startFace.vertices.size();
    visual.pushMatrix();
    visual.translate(startFace.position.x, startFace.position.y, startFace.position.z);
    visual.rotateX(startFace.orientation.x);
    visual.rotateY(startFace.orientation.y);
    visual.rotateZ(startFace.orientation.z);
    visual.scale(startFace.scale.x, startFace.scale.y, startFace.scale.z);
    for(int i = 0; i < numVert-1; i++){
      visual.beginShape();
      visual.vertex(startFace.vertices.get(i).x, startFace.vertices.get(i).y, startFace.vertices.get(i).z);
      visual.vertex(startFace.vertices.get(i+1).x, startFace.vertices.get(i+1).y, startFace.vertices.get(i+1).z);
      visual.vertex((endFace.position.x-startFace.position.x)+endFace.vertices.get(i+1).x,
                    (endFace.position.y-startFace.position.y)+endFace.vertices.get(i+1).y,
                    (endFace.position.z-startFace.position.z)+endFace.vertices.get(i+1).z);
      visual.vertex((endFace.position.x-startFace.position.x)+endFace.vertices.get(i).x,
                    (endFace.position.y-startFace.position.y)+endFace.vertices.get(i).y,
                    (endFace.position.z-startFace.position.z)+endFace.vertices.get(i).z);
      visual.endShape(CLOSE);
    }
    visual.beginShape();
    visual.vertex(startFace.vertices.get(numVert-1).x, startFace.vertices.get(numVert-1).y, startFace.vertices.get(numVert-1).z);
    visual.vertex(startFace.vertices.get(0).x, startFace.vertices.get(0).y, startFace.vertices.get(0).z);
    visual.vertex((endFace.position.x-startFace.position.x)+endFace.vertices.get(0).x,
                  (endFace.position.y-startFace.position.y)+endFace.vertices.get(0).y,
                  (endFace.position.z-startFace.position.z)+endFace.vertices.get(0).z);
    visual.vertex((endFace.position.x-startFace.position.x)+endFace.vertices.get(numVert-1).x,
                  (endFace.position.y-startFace.position.y)+endFace.vertices.get(numVert-1).y,
                  (endFace.position.z-startFace.position.z)+endFace.vertices.get(numVert-1).z);
    visual.endShape(CLOSE); 
   visual.popMatrix(); 
  }
  
  public Vector3D getPointWithThisY(float y){
    float percent = (y-start.y)/(end.y-start.y);
    float x = percent*(end.x-start.x)+start.x;
    float z = percent*(end.z-start.z)+start.z;
    return new Vector3D(x, y, z);
  }
}

