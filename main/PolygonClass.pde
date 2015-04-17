public class Polygon {
  int sides;
  float radius;
  Vector3D position;
  Vector3D orientation;
  Vector3D scale;
  Vector3D RGBcolor;
  ArrayList<Vector3D> vertices;
  
  public Polygon(int sides, Vector3D position, float radius){
    this.position = position;
    this.orientation = new Vector3D(0, 0, 0);
    this.scale = new Vector3D(1, 1, 1);
    this.sides = sides;
    this.radius = radius;
    this.RGBcolor = new Vector3D(255, 255, 255);
    final double changeOfAngle = 2 * PI / this.sides;
    double angle = 0;
    vertices = new ArrayList<Vector3D>();
    for(int i = 0; i < this.sides; i++){
      vertices.add(new Vector3D(radius * Math.cos(angle), 0, radius * Math.sin(angle)));
      angle += changeOfAngle;
    }
  }
  
  public void drawPolygon(PApplet visual){
    visual.pushMatrix();
    visual.translate(this.position.x, this.position.y, this.position.z);
    visual.rotateX(this.orientation.x);
    visual.rotateY(this.orientation.y);
    visual.rotateZ(this.orientation.z);
    visual.scale(this.scale.x, this.scale.y, this.scale.z);
    visual.fill(this.RGBcolor.x, this.RGBcolor.y, this.RGBcolor.z);
    visual.beginShape();
    for(Vector3D vertex: vertices){
      visual.vertex(vertex.x, 0, vertex.z);
    }
    visual.endShape();
    visual.popMatrix();
  }
  
  public void setOrientation(Vector3D normal){
    float angle = (float) Math.asin(Math.abs(normal.z)/normal.magnitude());
    if(normal.x < 0 && normal.z > 0) this.orientation.y = angle;
    else if(normal.x > 0 && normal.z > 0) this.orientation.y = (PI - angle);
    else if(normal.x > 0 && normal.z < 0) this.orientation.y = (PI + angle);
    else if(normal.x < 0 && normal.z < 0) this.orientation.y = -angle;
    else if(normal.z == 0 && normal.x < 0) this.orientation.y = 0;
    else if(normal.x == 0 && normal.z > 0) this.orientation.y = (PI/2.0);
    else if(normal.z == 0 && normal.x > 0) this.orientation.y = PI;
    else if(normal.x == 0 && normal.z < 0) this.orientation.y = (3*PI/2.0);
    this.orientation.z = -normal.y;
  }
}

