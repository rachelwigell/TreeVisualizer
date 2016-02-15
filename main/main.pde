import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

  public final int fieldX = 800;
  public final int fieldY = 600;
  public final int fieldZ = 700;
  Line line;
  Deciduous3 root;
  PeasyCam camera;
  
  public void setup(){
    size(800, 600, P3D);
    camera = new PeasyCam(this, 0, 0, 0, 200);
    this.root = new Deciduous3(new Vector3D(0, 50, 0), 3, 4, 3);
  }
  
  public void draw(){
    background(0);
    lights();
    root.drawRoot("solid");
  }