public class Deciduous2 {
  Deciduous2 root;
  Line path;
  int numBranches;
  Deciduous2[] branches;
  int level;
  int endLevel;
  
  public Deciduous2(Vector3D position, int numBranches, int endLevel){
    float yDist = random(60, 80);
    float xAngle = random(-10, 10);
    float zAngle = random(-10, 10);
    Vector3D endPos = new Vector3D(position.x+xAngle, position.y-yDist, position.z+zAngle);
    this.path = new Line(position, endPos,  new Polygon(5, yDist/6.0), new Polygon(5, yDist/14.0));
    this.numBranches = numBranches;
    this.endLevel = endLevel;
    this.level = 1;
    this.branches = new Deciduous2[numBranches];
    for(int i = 0; i < numBranches-1; i++){
      branches[i] = new Deciduous2(this);
    }
    branches[numBranches-1] = new Deciduous2(this);
  }
  
  public Deciduous2(Deciduous2 root){
    this.level = root.level+1;
    this.numBranches = root.numBranches-1;
    this.endLevel = root.endLevel;
    float branchLength = random(.7, .9)*root.path.length/(sqrt(sqrt(this.level)));
    float yNorm = random(-1, -.3); 
    float xNorm = random(-1, 1);
    float zNorm = random(-1, 1);
    Vector3D branchEnd = root.path.end.addVector(new Vector3D(xNorm, yNorm, zNorm).multiplyScalar(branchLength));
    this.path = new Line(root.path.end, branchEnd, new Polygon(5, 100/(this.level*this.level*5)), new Polygon(5, 100/(this.level*this.level*10)));
    if(this.level < this.endLevel){
      this.branches = new Deciduous2[numBranches];
      for(int i = 0; i < numBranches; i++){
        branches[i] = new Deciduous2(this);
      }
    }
  }
  
  public void drawBranch(String style){
    if(style == "boxes"){
      this.path.drawBox();
    }
    else if(style == "lines"){
      this.path.drawLine();
    }
    else if(style == "solid"){
      this.path.drawSolid();
    }
    if(this.level < this.endLevel){
      for(Deciduous2 b: this.branches){
        b.drawBranch(style);
      }
    }
  }
}