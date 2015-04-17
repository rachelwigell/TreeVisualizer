import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

  public final int fieldX = 800;
  public final int fieldY = 600;
  public final int fieldZ = 700;
  Polygon poly;
  Line line;
  Branch root;
  PeasyCam camera;
  
  public void setup(){
    size(fieldX, fieldY, P3D);
//    camera(400, 300, 700, 400, 300, 350, 0, -1, 0);
    camera = new PeasyCam(this, 0, 0, 0, 200);
//    poly = new Polygon(5, new Vector3D(0, 0, 0), 10);
    this.root = new Branch(new Line(new Vector3D(0, 50, 0), new Vector3D(random(-10,10), -50, random(-10,10)), new Polygon(5, new Vector3D(0, 50, 0), 10), new Polygon(5, new Vector3D(0, -50, 0), 1)), 7, 3, 5);
//    this.root.printInfo();
//    line = new Line(new Vector3D(0, 50, 0), new Vector3D(0, -50, 0), new Polygon(5, new Vector3D(0, 50, 0), 20), new Polygon(5, new Vector3D(0, -50, 0), 10));setOrientation(new Vector3D(.707, .707, 0));
//    line.endFace.setOrientation(new Vector3D(.707, .707, 0));
  }
  
  public void draw(){
    background(0);
    lights();
//    poly.drawPolygon(this);
//    line.drawSolid(this);
    root.drawBranch(this, true);
  }

