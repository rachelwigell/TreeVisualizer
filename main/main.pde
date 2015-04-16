import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

  public final int fieldX = 800;
  public final int fieldY = 600;
  public final int fieldZ = 700;
  //Polygon poly;
  Branch root;
  PeasyCam camera;
  
  public void setup(){
    size(fieldX, fieldY, P3D);
//    camera(400, 300, 700, 400, 300, 350, 0, -1, 0);
    camera = new PeasyCam(this, 0, 0, 0, 200);
//    poly = new Polygon(9);
    this.root = new Branch(new Line(new Vector3D(0, 50, 0), new Vector3D(0, -50, 0)), 8, 3);
//    this.root.printInfo();
//    println(random(1,4));
//    println(random(4,1));
//    println(random(-3));
  }
  
  public void draw(){
    background(0);
//    poly.drawPolygon(this);
    stroke(255);
    root.drawBranch(this);
  }

