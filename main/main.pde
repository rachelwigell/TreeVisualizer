import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

  public final int fieldX = 800;
  public final int fieldY = 600;
  public final int fieldZ = 700;
  Line line;
  Branch root;
  PeasyCam camera;
  
  public void setup(){
    size(800, 600, P3D);
    camera = new PeasyCam(this, 0, 0, 0, 200);
    this.root = new Branch(new Vector3D(0, 50, 0), 10, 3);
  }
  
  public void draw(){
    background(0);
    lights();
    root.drawBranch("solid");
  }